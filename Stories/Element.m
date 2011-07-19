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

#import "Element.h"
#import "Author.h"
#import "Image.h"

@implementation Element

@synthesize source=_source;
@synthesize elementClass=_elementClass;
@synthesize permalinkURL=_permalinkURL;
@synthesize title=_title;
@synthesize description=_description;
@synthesize thumbnailURL=_thumbnailURL;
@synthesize faviconURL=_faviconURL;
@synthesize author=_author;
@synthesize creationDate=_creationDate;
@synthesize additionDate=_additionDate;
@synthesize oembed=_oembed;
@synthesize image=_image;


- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        id source = [dictionary objectForKey:@"source"];
        if (source && [source isKindOfClass:[NSString class]]) {
            [self setSource:source];
        }
        id elementClass = [dictionary objectForKey:@"elementClass"];
        if (elementClass && [elementClass isKindOfClass:[NSString class]]) {
            [self setElementClass:elementClass];
        }
        id permalink = [dictionary objectForKey:@"permalink"];
        if (permalink && [permalink isKindOfClass:[NSString class]]) {
            [self setPermalinkURL:[NSURL URLWithString:permalink]];
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
        }
        id favicon = [dictionary objectForKey:@"favicon"];
        if (favicon && [favicon isKindOfClass:[NSString class]]) {
            [self setFaviconURL:[NSURL URLWithString:favicon]];
        }
        id author = [dictionary objectForKey:@"author"];
        if (author && [author isKindOfClass:[NSDictionary class]]) {
            [self setAuthor:[[Author alloc] initWithDictionary:author]];
        }
        id createdAt = [dictionary objectForKey:@"created_at"];
        if (createdAt && [createdAt isKindOfClass:[NSString class]]) {
            [self setCreationDate:[NSDate dateWithTimeIntervalSince1970:[createdAt integerValue]]];
        }
        id addedAt = [dictionary objectForKey:@"added_at"];
        if (addedAt && [addedAt isKindOfClass:[NSString class]]) {
            [self setAdditionDate:[NSDate dateWithTimeIntervalSince1970:[addedAt integerValue]]];
        }
        id oembed = [dictionary objectForKey:@"oembed"];
        if (oembed && [oembed isKindOfClass:[NSDictionary class]]) {
            [self setOembed:[(NSDictionary *)oembed objectForKey:@"html"]];
        } else if (oembed && [oembed isKindOfClass:[NSString class]]) {
            [self setOembed:(NSString *)oembed];
        }
        
        id image = [dictionary objectForKey:@"image"];
        if (image && [image isKindOfClass:[NSDictionary class]]) {
            [self setImage:[[Image alloc] initWithDictionary:image]];
        }
    }
    
    return self;
}


- (NSString *)HTML {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"MMMM dd, yyyy 'at' hh:mm"];
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    BOOL appendAuthorInfo = NO;
    
    [output appendFormat:@"<div class=\"story-element source-%@\">", [self source]];
    
    if ([[self source] isEqualToString:@"storify"]) {
        if (![self oembed]) {
            [output appendString:@"<div class=\"text\">"];
            [output appendString:[self description]];
            [output appendString:@"</div>"];
        } else {
            [output appendString:[self oembed]];
        }
    } else if ([[self source] isEqualToString:@"twitter"] || [[self source] isEqualToString:@"facebook"]) {
        if ([self image]) {
            [output appendString:[[self image] HTML]];
        }
        
        [output appendString:@"<div class=\"text\">"];
        [output appendString:[self description]];
        [output appendString:@"</div>"];
        appendAuthorInfo = YES;
    } else if ([[self source] isEqualToString:@"youtube"] || [[self source] isEqualToString:@"SlideShare"]) {
        if ([self oembed]) {
            [output appendString:[self oembed]];
        }
        
        [output appendString:@"<div class=\"title\">"];
        [output appendString:[self title]];
        [output appendString:@"</div>"];
        appendAuthorInfo = YES;
    } else if ([[self source] isEqualToString:@"xml"] || [[self source] isEqualToString:@"google"]) {
        [output appendString:@"<div class=\"title\">"];
        [output appendFormat:@"<a href=\"%@\">%@</a>", [self permalinkURL], [self title]];
        [output appendString:@"</div>"];
        
        [output appendString:@"<div class=\"text\">"];
        [output appendString:[self description]];
        [output appendString:@"</div>"];
        appendAuthorInfo = YES;
    } else if ([[self source] isEqualToString:@"flickr"]) {
        if ([self image]) {
            [output appendString:[[self image] HTML]];
        }
        
        [output appendString:@"<div class=\"title\">"];
        [output appendFormat:@"<a href=\"%@\">Photo by %@</a>", [self permalinkURL], [self title]];
        [output appendString:@"</div>"];
    }
    
    if (appendAuthorInfo && [self author]) {
        [output appendString:@"<div class=\"author\">"];
        
        if ([[self author] permalinkURL]) {
            [output appendFormat:@"<span class=\"name\"><a href=\"%@\">%@</a></span>", [[self author] permalinkURL], [[self author] name]];
        } else {
            [output appendFormat:@"<span class=\"name\">%@</span>", [[self author] name]];
        }
        
        [output appendFormat:@"<span class=\"permalink\"><img src=\"%@\" alt=\"\"/><a href=\"%@\">%@</a></span>", [self faviconURL], [self permalinkURL], [dateFormatter stringFromDate:[self creationDate]]];
        
        if ([[self author] avatarURL]) {
            [output appendFormat:@"<img class=\"avatar\" src=\"%@\" alt=\"\"/>", [[self author] avatarURL]];
        }
        
        [output appendString:@"</div>"];
    }
    
    [output appendString:@"</div>"];
    
    return [output autorelease];
}


#pragma mark -

- (void)dealloc {
    [_image release];
    [_oembed release];
    [_additionDate release];
    [_creationDate release];
    [_author release];
    [_faviconURL release];
    [_thumbnailURL release];
    [_description release];
    [_title release];
    [_permalinkURL release];
    [_elementClass release];
    [_source release];
    
    [super dealloc];
}

@end