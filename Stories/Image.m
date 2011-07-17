//
//  Image.m
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import "Image.h"

@interface Image()
- (void)generateHtml;
@end

@implementation Image

@synthesize srcUrl;
@synthesize hrefUrl;

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
        
        [self generateHtml];
    }
    
    return self;
}

- (void)dealloc
{
    [m_html release];
    [m_dictionary release];
    [super dealloc];
}

//////////////////////////////////////////////////////////////
#pragma mark - Private methods
//////////////////////////////////////////////////////////////

- (void)generateHtml
{
    m_html = [[NSString stringWithFormat:@"<a href=\"%@\"><img src=\"%@\" alt=\"\"/></a>", [[NSString stringWithFormat:@"%@", self.hrefUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [[NSString stringWithFormat:@"%@", self.srcUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] retain];
}

//////////////////////////////////////////////////////////////
#pragma mark - Public methods
//////////////////////////////////////////////////////////////

- (NSURL *)srcUrl
{
    NSString* src = [m_dictionary objectForKey:@"src"];
    if (src && [src isEqualToString:@"null"] == NO)
        return [NSURL URLWithString:src];
    else
        return nil;
}

- (NSURL *)hrefUrl
{
    NSString* href = [m_dictionary objectForKey:@"href"];
    if (href && [href isEqualToString:@"null"] == NO)
        return [NSURL URLWithString:href];
    else
        return nil;
}

@end
