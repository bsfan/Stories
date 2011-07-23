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


@interface Story ()
- (NSString *)formattedDateRelativeToNow:(NSDate *)date;
@end


@implementation Story

@synthesize permalinkURL=_permalinkURL;
@synthesize permalinkJSONURL=_permalinkJSONURL;
@synthesize publicationDate=_publicationDate;
@synthesize author=_author;
@synthesize shortURL=_shortURL;
@synthesize title=_title;
@synthesize description=_description;
@synthesize thumbnailURL=_thumbnailURL;
@synthesize topics=_topics;
@synthesize elements=_elements;


- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        id permalink = [dictionary objectForKey:@"permalink"];
        if (permalink && [permalink isKindOfClass:[NSString class]]) {
            [self setPermalinkURL:[NSURL URLWithString:permalink]];
            [self setPermalinkJSONURL:[NSURL URLWithString:[(NSString *)permalink stringByAppendingString:@".json"]]];
        }
        id publishedAt = [dictionary objectForKey:@"published_at"];
        if (publishedAt && [publishedAt isKindOfClass:[NSString class]]) {
            [self setPublicationDate:[NSDate dateWithTimeIntervalSince1970:[(NSString *)publishedAt integerValue]]];
        }
        id author = [dictionary objectForKey:@"author"];
        if (author && [author isKindOfClass:[NSDictionary class]]) {
            [self setAuthor:[[Author alloc] initWithDictionary:author]];
        }
        id shorturl = [dictionary objectForKey:@"shorturl"];
        if (shorturl && [shorturl isKindOfClass:[NSString class]]) {
            [self setShortURL:[NSURL URLWithString:shorturl]];
        }
        id title = [dictionary objectForKey:@"title"];
        if (title && [title isKindOfClass:[NSString class]]) {
            [self setTitle:title];
        }
        id description = [dictionary objectForKey:@"description"];
        if (description && [description isKindOfClass:[NSString class]]) {
            [self setDescription:description];
        }
        id thumbnail = [dictionary objectForKey:@"thumbnail"];
        if (thumbnail && [thumbnail isKindOfClass:[NSString class]]) {
            [self setThumbnailURL:[NSURL URLWithString:thumbnail]];
        } else {
            [self setThumbnailURL:[_author avatarURL]];
        }
        id topics = [dictionary objectForKey:@"topics"];
        if (topics && [topics isKindOfClass:[NSArray class]]) {
            [self setTopics:topics];
        }
        
        NSDictionary *elementDictionary = [dictionary objectForKey:@"elements"];
        //        NSArray *elementKeys = [elementDictionary keysSortedByValueUsingSelector:@selector(compare:)];
        NSArray *elementKeys = [elementDictionary allKeys];
        
        NSMutableArray *elements = [NSMutableArray arrayWithCapacity:[elementKeys count]];
        
        for (NSString *key in [elementKeys sortedArrayUsingSelector:@selector(compare:)]) {
            [elements addObject:[[Element alloc] initWithDictionary:[elementDictionary objectForKey:key]]];
        }
        [self setElements:elements];
    }
    
    return self;
}


- (NSString *)HTML {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"MMMM dd, yyyy 'at' h:mm aaa"];
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    [output appendString:@"<!DOCTYPE html>\r\n<html><head>\r\n<meta http-equiv=\"Content-type\" content=\"text/html;charset=UTF-8\">\r\n"];
    [output appendString:@"<style \"type\"=\"text/css\">\r\n"];
    [output appendString:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"base" ofType:@"css"] encoding:NSUTF8StringEncoding error:nil]];
    [output appendString:@"</style>\r\n</head>\r\n"];

    [output appendString:@"<body>\r\n"];
    [output appendString:@"<div class=\"story\">\r\n"];
    [output appendFormat:@"<h1>%@</h1>\r\n", [self title]];
    //    if ([self author]) {
    //        if ([self publicationDate]) {
    //            [output appendFormat:@"<h2><img src=\"%@\" alt=\"\"/>By <a href=\"%@\">%@</a>, published on %@</h2>\r\n", [[self author] avatarURL], [[self author] permalinkURL], [dateFormatter stringFromDate:[self publicationDate]]];
    //        } else {
    //            [output appendFormat:@"<h2><img src=\"%@\" alt=\"\"/>By <a href=\"%@\">%@</a></h2>\r\n", [[self author] avatarURL], [[self author] permalinkURL]];
    //        }
    //    }
    if ([self description]) {
        [output appendFormat:@"<p class=\"story-description\">%@</p>", [self description]];
    }
    for (Element *element in [self elements]) {
        [output appendString:[element HTML]];
    }
    [output appendString:@"</div>\r\n</body>\r\n</html>"];
    
    return [output autorelease];
}


#pragma mark Private Methods

- (NSString *)formattedDateRelativeToNow:(NSDate *)date {
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


#pragma mark -

- (void)dealloc {
    [_elements release];
    [_topics release];
    [_thumbnailURL release];
    [_description release];
    [_title release];
    [_shortURL release];
    [_author release];
    [_publicationDate release];
    [_permalinkJSONURL release];
    [_permalinkURL release];
    
    [super dealloc];
}

@end