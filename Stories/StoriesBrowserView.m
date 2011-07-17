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

#import "StoriesBrowserView.h"
#import "Story.h"
#import "StoryThumbView.h"


@implementation StoriesBrowserView

@synthesize stories=_stories;
@synthesize scrollView=_scrollView;

- (id)initWithFrame:(CGRect)frame stories:(NSArray *)stories {
    self = [super initWithFrame:frame];
    if (self) {
        [self setStories:stories];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:[self frame]];
        [_scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"StoryBrowserBackground"]]];
        
        CGFloat thumbnailSpacing = 145.0;
        [_scrollView setContentSize:CGSizeMake(145 * [_stories count] + 30, 165.0)];
        
        for (int index=0; index<[_stories count]; index++) {
            
            CGRect thumbFrame = CGRectMake((thumbnailSpacing * index) + 30, 25.0, 115.0, 115.0);
            StoryThumbView *storyThumbView = [[StoryThumbView alloc] initWithFrame:thumbFrame story:[_stories objectAtIndex:index]];
            [_scrollView addSubview:storyThumbView];
        }
        
        //115x115 thumbnails
        //30px spacing
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)layoutSubviews {
    [_scrollView setFrame:[self frame]];
}


#pragma mark -

- (void)dealloc {
    [_scrollView release];
    
    [super dealloc];
}

@end