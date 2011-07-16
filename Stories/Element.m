//
//  Element.m
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import "Element.h"
#import "Author.h"

@implementation Element

//@synthesize editor;
@synthesize source;
@synthesize elementClass;
@synthesize permalinkUrl;
@synthesize title;
@synthesize description;
@synthesize thumbnailUrl;
@synthesize favIconUrl;
@synthesize author = m_author;
@synthesize createdAt;
@synthesize addedAt;

- (id)init
{
    return [self initWithDictionary:nil];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        m_dictionary = [dictionary retain];
        m_author = [[[Author alloc] initWithDictionary:[dictionary objectForKey:@"author"]] retain];
    }
    
    return self;
}

- (void) dealloc
{
    [m_dictionary release];
    [super dealloc];
}

- (NSString *)source
{
    return [m_dictionary objectForKey:@"source"];
}

- (NSString *)elementClass
{
    return [m_dictionary objectForKey:@"elementClass"];
}

- (NSURL *)permalinkUrl
{
    return [NSURL URLWithString:[m_dictionary objectForKey:@"permalink"]];
}

- (NSString *)title
{
    return [m_dictionary objectForKey:@"title"];
}

- (NSString *)description
{
    return [m_dictionary objectForKey:@"description"];
}

- (NSURL *)thumbnailUrl
{
    return [NSURL URLWithString:[m_dictionary objectForKey:@"thumbnail"]];
}

- (NSURL *)favIconUrl
{
    return [NSURL URLWithString:[m_dictionary objectForKey:@"favicon"]];
}

- (NSDate *)createdAt
{
    return [NSDate dateWithTimeIntervalSince1970:[[m_dictionary objectForKey:@"created_at"] integerValue]];
}

- (NSDate *)addedAt
{
    return [NSDate dateWithTimeIntervalSince1970:[[m_dictionary objectForKey:@"added_at"] integerValue]];
}

@end
