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
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"SearchBackground"]]];
        
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
    CGRect searchTextFieldFrame = CGRectMake(280.0, 490.0, 335.0, 31.0);
    [_searchTextField setFrame:searchTextFieldFrame];
    
    CGRect searchButtonFrame = CGRectMake(630.0, 484.0, 140.0, 45.0);
    [_searchButton setFrame:searchButtonFrame];
}


#pragma mark -

- (void)dealloc {
    [_searchButton release];
    [_searchTextField release];
    
    [super dealloc];
}

@end