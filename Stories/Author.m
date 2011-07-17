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

#import "Author.h"

@implementation Author

@synthesize username;
@synthesize name;
@synthesize avatarUrl;
@synthesize description;
@synthesize location;
@synthesize website;
@synthesize permalinkUrl;

- (id)init
{
    return [self initWithDictionary:nil];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        m_dictionary = [dictionary retain];
    }
    
    return self;
}

- (void)dealloc
{
    [m_dictionary release];
    [super dealloc];
}

//////////////////////////////////////////////////////////////
#pragma mark - Public methods
//////////////////////////////////////////////////////////////

- (NSString *)username
{
    return [m_dictionary objectForKey:@"username"];
}

- (NSString *)name
{
    return [m_dictionary objectForKey:@"name"];
}

- (NSURL *)avatarUrl
{
    return [NSURL URLWithString:[m_dictionary objectForKey:@"avatar"]];
}

- (NSString *)description
{
    return [m_dictionary objectForKey:@"description"];
}

- (NSString *)location
{
    return [m_dictionary objectForKey:@"location"];
}

- (NSString *)website
{
    return [m_dictionary objectForKey:@"website"];
}

- (NSURL *)permalinkUrl
{
    return [NSURL URLWithString:[m_dictionary objectForKey:@"permalink"]];
}

@end
