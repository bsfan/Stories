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

#import "SearchViewController.h"
#import "SearchView.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "Story.h"
#import "StoriesViewController.h"


@implementation SearchViewController

@synthesize searchView=_searchView;

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

- (void)loadView {
    _searchView = [[SearchView alloc] initWithFrame:CGRectZero];
    [_searchView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [_searchView setBackgroundColor:[UIColor redColor]];
    [[_searchView searchButton] addTarget:self action:@selector(performSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setView:_searchView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    _searchView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Actions

- (void)performSearch:(id)sender {
    NSString *query = [[_searchView searchTextField] text];
    if (!query) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have to enter a topic to perform a search." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kAPITopicsURL, [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setResponseEncoding:NSUTF8StringEncoding];
    [request setCompletionBlock:^(void) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (200 == [request responseStatusCode]) {
            NSString *response = [request responseString];

            NSDictionary *responseDictionary = [response objectFromJSONString];
            
            NSInteger storyCount = [[responseDictionary objectForKey:@"count"] integerValue];
            
            if (storyCount > 0) {
                [[_searchView searchTextField] resignFirstResponder];
                
                NSMutableArray *stories = [NSMutableArray arrayWithCapacity:storyCount];
                for (NSDictionary *storyDictionary in [responseDictionary objectForKey:@"stories"]) {
                    Story *story = [[Story alloc] initWithDictionary:storyDictionary];
                    [stories addObject:story];
                    [story release];
                }
                
                StoriesViewController *storiesViewController = [[StoriesViewController alloc] initWithStories:stories];
                [[self navigationController] pushViewController:storiesViewController animated:YES];
                [storiesViewController release];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No stories have been found with this topic. Please retry." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
    }];
    
    [request startAsynchronous];
}

#pragma mark -

- (void)dealloc {
    [_searchView release];
    
    [super dealloc];
}

@end