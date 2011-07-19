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

#import "StoryThumbView.h"
#import "Story.h"
#import "Author.h"
#import "EGOImageView.h"


@implementation StoryThumbView

@synthesize story=_story;
@synthesize imageView=_imageView;
@synthesize titleLabel=_titleLabel;

- (id)initWithFrame:(CGRect)frame story:(Story *)story {
    self = [super initWithFrame:frame];
    if (self) {
        [self setStory:story];
        [self setBackgroundColor:[UIColor blackColor]];
        
        _imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder"]];
        
        [_imageView setImageURL:[story thumbnailURL]];
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_titleLabel setNumberOfLines:2];
        [_titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [_titleLabel setText:[story title]];
        [_titleLabel setAlpha:0.8];
        [self addSubview:_titleLabel];
    
        UITapGestureRecognizer *tapGestureRegognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGestureRegognizer];
        [tapGestureRegognizer release];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect titleLabelFrame = CGRectMake(5.0, 70.0, 105.0, 40.0);
    [_titleLabel setFrame:titleLabelFrame];
}


- (void)handleTapGesture:(UIGestureRecognizer *)sender {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              [_story permalinkJSONURL] , @"PermalinkURL", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidSelectStory" object:nil userInfo:userInfo];
}


#pragma mark -

- (void)dealloc {
    [_imageView release];
    [_titleLabel release];
    
    [super dealloc];
}

@end