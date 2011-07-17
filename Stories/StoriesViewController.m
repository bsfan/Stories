//
//  Copyright 2011 StoriesAppTeam
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "StoriesViewController.h"
#import "StoriesBrowserView.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "StoryView.h"
#import "Story.h"


@implementation StoriesViewController

@synthesize stories=_stories;
@synthesize backgroundView=_backgroundView;
@synthesize storiesBrowserView=_storiesBrowserView;
@synthesize storyView=_storyView;

- (id)initWithStories:(NSArray *)stories {
    self = [super init];
    if (self) {
        [self setStories:stories];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:@"DidSelectStory" object:nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

- (void)loadView {
//    _backgroundView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [_backgroundView setImage:[UIImage imageNamed:@"Background"]];
//    [self setView:_backgroundView];
    
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [view setBackgroundColor:[UIColor redColor]];
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    [self setView:view];
    
    CGRect storiesBrowserViewFrame = CGRectMake(0.0, 0.0, 1024.0, 165.0);
    _storiesBrowserView = [[StoriesBrowserView alloc] initWithFrame:storiesBrowserViewFrame stories:_stories];
    [[self view] addSubview:_storiesBrowserView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    _backgroundView = nil;
    _storiesBrowserView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}


- (void)didReceiveNotification:(NSNotification *)notification {
    if ([[notification name] isEqualToString:@"DidSelectStory"]) {
        NSDictionary *userInfo = [notification userInfo];
        NSURL *url = [userInfo objectForKey:@"PermalinkURL"];
        
        NSLog(@"permalink url: %@", url);
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setResponseEncoding:NSUTF8StringEncoding];
        [request setCompletionBlock:^(void) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if (200 == [request responseStatusCode]) {
                if ([self storyView]) {
                    [_storyView removeFromSuperview];
                    [_storyView release];
                }
                NSString *response = [request responseString];
                
//                NSLog(@"%@", response);
                NSDictionary *responseDictionary = [response objectFromJSONString];
                Story *fullStory = [[Story alloc] initWithDictionary:responseDictionary];
                
//                CGRect storyViewFrame = CGRectMake(0.0, 165.0, 1024.0, 603.0);
                CGRect storyViewFrame = CGRectMake(0.0, 165.0, 1024.0, 603.0);
                [self setStoryView:[[StoryView alloc] initWithFrame:storyViewFrame story:fullStory]];
                
                [[self view] addSubview:[self storyView]];
            }
            
        }];
        [request startAsynchronous];
    }
}


#pragma mark -

- (void)dealloc {
    [_backgroundView release];
    [_storiesBrowserView release];
    
    [super dealloc];
}

@end