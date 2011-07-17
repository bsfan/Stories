//
//  Element.m
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import "Element.h"
#import "Author.h"
#import "Image.h"

@interface Element()
- (void)generateHtml;
@end

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
@synthesize oEmbedHtml;
@synthesize image = m_image;;

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
        
        if ([dictionary objectForKey:@"image"])
            m_image = [[[Image alloc] initWithDictionary:[dictionary objectForKey:@"image"]] retain];
        
        [self generateHtml];
    }
    
    return self;
}

- (void) dealloc
{
    [m_html release];
    [m_image release];
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
    
    [tags addObject:[NSString stringWithFormat:@"<div class=\"story-element source-%@\">", self.source]];
    
    BOOL displayAuthor = NO;
    
    if ([self.source isEqualToString:@"storify"])
    {
        if (self.oEmbedHtml == nil)
        {
            // Text
            [tags addObject:@"<div class=\"text\">"];
            [tags addObject:self.description];
            [tags addObject:@"</div>"];
        }
        else
        {
            // Embedded story
            [tags addObject:self.oEmbedHtml];
        }
    }
    else if ([self.source isEqualToString:@"twitter"] ||
             [self.source isEqualToString:@"facebook"])
    {
        // Image (if available)
        if (self.image)
            [tags addObject:self.image.html];
        
        // Tweet/Facebook Post
        [tags addObject:@"<div class=\"text\">"];
        [tags addObject:self.description];
        [tags addObject:@"</div>"];

        displayAuthor = YES;
    }
    else if ([self.source isEqualToString:@"youtube"] ||
             [self.source isEqualToString:@"SlideShare"])
    {
        // Embed
        [tags addObject:self.oEmbedHtml];
        
        // Title
        [tags addObject:@"<div class=\"title\">"];
        [tags addObject:self.title];
        [tags addObject:@"</div>"];
        
        displayAuthor = YES;
    }
    else if ([self.source isEqualToString:@"xml"] ||
             [self.source isEqualToString:@"google"])
    {
        // Title
        [tags addObject:@"<div class=\"title\">"];
        [tags addObject:[NSString stringWithFormat:@"<a href=\"%@\">%@</a>", self.permalinkUrl, self.title]];
        [tags addObject:@"</div>"];
        
        // Text
        [tags addObject:@"<div class=\"text\">"];
        [tags addObject:self.description];
        [tags addObject:@"</div>"];
        
        displayAuthor = YES;
    }
    else if ([self.source isEqualToString:@"Feedburner"])
    {
        // TODO: Support Feedburder source
    }
    else if ([self.source isEqualToString:@"flickr"])
    {
        // Image (if available)
        if (self.image)
            [tags addObject:self.image.html];
        
        // Title
        [tags addObject:@"<div class=\"title\">"];
        [tags addObject:[NSString stringWithFormat:@"<a href=\"%@\">Photo by %@</a>", self.permalinkUrl, self.title]];
        [tags addObject:@"</div>"];
    }
    else
    {
        // TODO: Support unknown sources
    }
    
    // Author and date published
    if (displayAuthor == YES && self.author)
    {
        [tags addObject:@"<div class=\"author\">"];
        
        if (self.author.permalinkUrl)
            [tags addObject:[NSString stringWithFormat:@"<span class=\"name\"><a href=\"%@\">%@</a></span>", self.author.permalinkUrl, self.author.name]];
        else
            [tags addObject:[NSString stringWithFormat:@"<span class=\"name\">%@</span>", self.author.name]];
        
        [tags addObject:[NSString stringWithFormat:@"<span class=\"permalink\"><img src=\"%@\"/><a href=\"%@\">%@</a></span>", self.favIconUrl, self.permalinkUrl, [dateFormatter stringFromDate:self.createdAt]]];
        
        if (self.author.avatarUrl)
            [tags addObject:[NSString stringWithFormat:@"<img class=\"avatar\" src=\"%@\"/>", self.author.avatarUrl]];
        
        [tags addObject:@"</div>"];	
    }    
    
    [tags addObject:@"</div>"];
    
    m_html = [[tags componentsJoinedByString:@"\n"] retain];
}

//////////////////////////////////////////////////////////////
#pragma mark - Public methods
//////////////////////////////////////////////////////////////

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

- (NSString *)oEmbedHtml
{
    return [[m_dictionary objectForKey:@"oembed"] objectForKey:@"html"];
}

@end
