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

@synthesize username=_username;
@synthesize name=_name;
@synthesize avatarURL=_avatarURL;
@synthesize description=_description;
@synthesize location=_location;
@synthesize website=_website;
@synthesize permalinkURL=_permalinkURL;


- (id)init {
    return [self initWithDictionary:nil];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        id username = [dictionary objectForKey:@"username"];
        if (username && [username isKindOfClass:[NSString class]]) {
            [self setUsername:username];
        }
        id name = [dictionary objectForKey:@"name"];
        if (name && [name isKindOfClass:[NSString class]]) {
            [self setName:name];
        }
        id avatar = [dictionary objectForKey:@"avatar"];
        if (avatar && [avatar isKindOfClass:[NSString class]]) {
            [self setAvatarURL:[NSURL URLWithString:avatar]];
        }
        id description = [dictionary objectForKey:@"description"];
        if (description && [description isKindOfClass:[NSString class]]) {
            [self setDescription:description];
        }
        id location = [dictionary objectForKey:@"location"];
        if (location && [location isKindOfClass:[NSString class]]) {
            [self setLocation:location];
        }
        id website = [dictionary objectForKey:@"website"];
        if (website && [website isKindOfClass:[NSString class]]) {
            [self setWebsite:website];
        }
        id permalink = [dictionary objectForKey:@"permalink"];
        if (permalink && [permalink isKindOfClass:[NSString class]]) {
            [self setPermalinkURL:[NSURL URLWithString:permalink]];
        }
    }
    
    return self;
}


#pragma mark -

- (void)dealloc {
    [_permalinkURL release];
    [_website release];
    [_location release];
    [_description release];
    [_avatarURL release];
    [_name release];
    [_username release];
    
    [super dealloc];
}

@end