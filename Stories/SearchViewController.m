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
    //TODO: perform search!
//    [self navigationController] pushViewController:<#(UIViewController *)#> animated:<#(BOOL)#>
}

#pragma mark -

- (void)dealloc {
    [_searchView release];
    
    [super dealloc];
}

@end