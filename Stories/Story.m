//
//  Story.m
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import "Story.h"
#import "Author.h"
#import "Element.h"

@interface Story()
- (void)generateHtml;
@end

@implementation Story

@synthesize permalinkUrl;
@synthesize permalinkJsonUrl;
@synthesize publishedAt;
@synthesize author = m_author;
@synthesize editors = m_editors;
@synthesize shortUrl;
@synthesize title;
@synthesize description;
@synthesize thumbnailUrl;
@synthesize topicsUrl = m_topicsUrl;
@synthesize elements = m_elements;
//@synthesize stats = m_stats;

@synthesize html = m_html;

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
        m_editors = [[[NSMutableArray alloc] init] retain];
        m_topicsUrl = [[[NSMutableArray alloc] init] retain];
        m_elements = [[[NSMutableArray alloc] init] retain];
//        m_stats = [[[Stats alloc] initWithDictionary:[dictionary objectForKey:@"stats"]] retain];
        
        NSDictionary* elements = [dictionary objectForKey:@"elements"];
        for (NSString* key in elements)
            [m_elements addObject:[[Element alloc] initWithDictionary:[elements objectForKey:key]]];
        
        [self generateHtml];
    }
    
    return self;
}

- (void)dealloc
{
    [m_html release];
//    [m_stats release];
    [m_elements release];
    [m_topicsUrl release];
    [m_editors release];
    [m_author release];
    [m_dictionary release];
    [super dealloc];
}

//////////////////////////////////////////////////////////////
#pragma mark - Private methods
//////////////////////////////////////////////////////////////

- (void)generateHtml
{
    NSMutableArray* tags = [NSMutableArray array];
    
    [tags addObject:@"<div class=\"story\">"];
    
    [tags addObject:[NSString stringWithFormat:@"<h1>%@</h1>", self.title]];
    [tags addObject:[NSString stringWithFormat:@"<h2><img src=\"%@\"/>By <a href=\"%@\">%@</a></h2>, published at %@", self.author.avatarUrl, self.author.permalinkUrl, self.author.name, self.publishedAt]];
    
    for (Element* element in m_elements)
        [tags addObject:element.html];
    
    [tags addObject:@"</div>"];

    m_html = [tags componentsJoinedByString:@"\n"];
}

//////////////////////////////////////////////////////////////
#pragma mark - Public methods
//////////////////////////////////////////////////////////////


- (NSURL *)permalinkUrl
{
    return [NSURL URLWithString:[m_dictionary objectForKey:@"permalink"]];
}

- (NSURL *)permalinkJsonUrl
{
    return [NSURL URLWithString:[[m_dictionary objectForKey:@"permalink"] stringByAppendingString:@".json"]];
}

- (NSDate *)publishedAt
{
    return [NSDate dateWithTimeIntervalSince1970:[[m_dictionary objectForKey:@"published_at"] integerValue]];
}

- (NSURL *)shortUrl
{
    return [NSURL URLWithString:[m_dictionary objectForKey:@"shorturl"]];
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

@end
