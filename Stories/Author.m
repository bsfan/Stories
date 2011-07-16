//
//  Author.m
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
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
