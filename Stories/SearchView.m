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

#import "SearchView.h"



@implementation SearchView

@synthesize searchTextField=_searchTextField;
@synthesize searchButton=_searchButton;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [self setContentSize:frame.size];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchBackground"]];
        [self addSubview:imageView];
        [imageView release];
        
        _searchTextField = [[UITextField alloc] init];
        [_searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [_searchTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_searchTextField setFont:[UIFont systemFontOfSize:16.0]];
        [_searchTextField setPlaceholder:@"Enter a topic"];
        
        UIImageView *magnifierImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Magnifier"]];
        [_searchTextField setLeftView:magnifierImageView];
        [_searchTextField setLeftViewMode:UITextFieldViewModeAlways];
        [magnifierImageView release];
        
        [_searchTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_searchTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_searchTextField setReturnKeyType:UIReturnKeySearch];
        [self addSubview:_searchTextField];
        
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setImage:[UIImage imageNamed:@"SearchButton"] forState:UIControlStateNormal];
        [_searchButton setTitle:@"Search" forState:UIControlStateNormal];
        [self addSubview:_searchButton];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect searchTextFieldFrame = CGRectMake(280.0, 490, 335.0, 31.0);
    [_searchTextField setFrame:searchTextFieldFrame];
    
    CGRect searchButtonFrame = CGRectMake(630.0, 484, 140.0, 45.0);
    [_searchButton setFrame:searchButtonFrame];
}

- (void)keyboardDidShow:(NSNotification *)notification {
	// keyboard frame is in window coordinates
	NSDictionary *userInfo = [notification userInfo];
	CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
	// convert own frame to window coordinates, frame is in superview's coordinates
    CGRect ownFrame = [[self window] convertRect:[self frame] fromView:[self superview]];
    
	// calculate the area of own frame that is covered by keyboard
	CGRect coveredFrame = CGRectIntersection(ownFrame, keyboardFrame);
    
	// now this might be rotated, so convert it back
    coveredFrame = [[self window] convertRect:coveredFrame toView:[self superview]];
    NSLog(@"coveredFrame: %@", NSStringFromCGRect(coveredFrame));
	// set inset to make up for covered array at bottom
    [self setContentInset:UIEdgeInsetsMake(0, 0, ownFrame.size.width + coveredFrame.size.height, 0)];
    [self setScrollIndicatorInsets:[self contentInset]];

}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setScrollIndicatorInsets:[self contentInset]];
}

#pragma mark -

- (void)dealloc {
    [_searchButton release];
    [_searchTextField release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

@end