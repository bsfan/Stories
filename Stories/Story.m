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
+ (NSString *)formattedDateRelativeToNow:(NSDate *)date;
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

+ (NSString *)formattedDateRelativeToNow:(NSDate *)date
{
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:date]];
    [mdf release];
    
    NSInteger dayDiff = (int)[midnight timeIntervalSinceNow] / (60*60*24);
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease]; 
    
    if(dayDiff == 0)
        [dateFormatter setDateFormat:@"'Today, 'h':'mm aaa"];
    else if(dayDiff == -1)
        [dateFormatter setDateFormat:@"'Yesterday, 'h':'mm aaa"];
    else if(dayDiff == -2)
        [dateFormatter setDateFormat:@"MMMM d', Two days ago'"];
    else if(dayDiff > -7 && dayDiff <= -2)
        [dateFormatter setDateFormat:@"MMMM d', This week'"];
    else if(dayDiff > -14 && dayDiff <= -7)
        [dateFormatter setDateFormat:@"MMMM d'; Last week'"];
    else if(dayDiff >= -60 && dayDiff <= -30)
        [dateFormatter setDateFormat:@"MMMM d'; Last month'"];
    else if(dayDiff >= -90 && dayDiff <= -60)
        [dateFormatter setDateFormat:@"MMMM d'; Within last three months'"];
    else if(dayDiff >= -180 && dayDiff <= -90)
        [dateFormatter setDateFormat:@"MMMM d'; Within last six months'"];
    else if(dayDiff >= -365 && dayDiff <= -180)
        [dateFormatter setDateFormat:@"MMMM d, YYYY'; Within this year'"];
    else if(dayDiff < -365)
        [dateFormatter setDateFormat:@"MMMM d, YYYY'; A long time ago'"];
    
    return [dateFormatter stringFromDate:date];
} 

- (void)generateHtml
{
    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"MMMM d, y 'at' h:mm aaa"];
        
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
    
    if (self.author)
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
    NSString* url = [m_dictionary objectForKey:@"permalink"];
    if (url && [url isKindOfClass:[NSNull class]] == NO)
        return [NSURL URLWithString:url];
    else
        return nil;
}

- (NSURL *)permalinkJsonUrl
{
    NSString* url = [m_dictionary objectForKey:@"permalink"];
    if (url && [url isKindOfClass:[NSNull class]] == NO)
        return [NSURL URLWithString:[url stringByAppendingString:@".json"]];
    else
        return nil;
}

- (NSDate *)publishedAt
{
    return [NSDate dateWithTimeIntervalSince1970:[[m_dictionary objectForKey:@"published_at"] integerValue]];
}

- (NSURL *)shortUrl
{
    NSString* url = [m_dictionary objectForKey:@"shorturl"];
    if (url && [url isKindOfClass:[NSNull class]] == NO)
        return [NSURL URLWithString:url];
    else
        return nil;
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
    NSString* url = [m_dictionary objectForKey:@"thumbnail"];
    if (url && [url isKindOfClass:[NSNull class]] == NO)
        return [NSURL URLWithString:url];
    else
        return nil;
}

@end
