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
        NSArray* elementsKeys = [elements allKeys];
        
        NSMutableArray* elementsKeysInt = [NSMutableArray arrayWithCapacity:elementsKeys.count];
        for (NSString* key in elementsKeys) {
            [elementsKeysInt addObject:[NSNumber numberWithInteger:[key integerValue]]];
        }

        for (NSNumber* key in [elementsKeysInt sortedArrayUsingSelector:@selector(compare:)])
            [m_elements addObject:[[Element alloc] initWithDictionary:[elements objectForKey:[NSString stringWithFormat:@"%@", key]]]];
        
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
    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"MMMM d, y 'at' h:m"];
        
    NSMutableArray* tags = [NSMutableArray array];

    [tags addObject:@"<!DOCTYPE html>"];
    [tags addObject:@"<html>"];
    [tags addObject:@"<head>"];
    
    [tags addObject:[NSString stringWithFormat:@"<title>%@</title>", self.title]];
    [tags addObject:@"<meta http-equiv=\"Content-type\" content=\"text/html;charset=UTF-8\">"];
    
    [tags addObject:@"<style TYPE=\"text/css\">"];
    [tags addObject:@"<!--"];
    [tags addObject:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"base" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil]];
    [tags addObject:@"-->"];
    [tags addObject:@"</style>"];

    [tags addObject:@"</head>"];
    [tags addObject:@"<body>"];
        
    [tags addObject:@"<div class=\"story\">"];
    
    [tags addObject:[NSString stringWithFormat:@"<h1>%@</h1>", self.title]];
    [tags addObject:[NSString stringWithFormat:@"<h2><img src=\"%@\" alt=\"\"/>By <a href=\"%@\">%@</a>, published on %@</h2>", [[NSString stringWithFormat:@"%@", self.author.avatarUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [[NSString stringWithFormat:@"%@", self.author.permalinkUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], self.author.name, [dateFormatter stringFromDate:self.publishedAt]]];

    if (self.description)
        [tags addObject:[NSString stringWithFormat:@"<p class=\"story-description\">%@</p>", self.description]];

    for (Element* element in m_elements)
    {
        if (![element.source isEqualToString:@"Feedburner"])
            [tags addObject:element.html];
    }
    
    [tags addObject:@"</div>"];

    [tags addObject:@"</body>"];
    [tags addObject:@"</html>"];

    m_html = [[tags componentsJoinedByString:@"\n"] retain];
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
