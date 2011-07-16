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

#import "ApplicationCore.h"


@implementation ApplicationCore

static ApplicationCore *s_applicationCore;

+ (ApplicationCore *)default {
    if (s_applicationCore == nil) {
        s_applicationCore = [[ApplicationCore alloc] init];
    }
    
    return s_applicationCore;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}


#pragma mark -

- (void)dealloc {
    [super dealloc];
}

@end