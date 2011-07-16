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

@synthesize html;

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
    m_html = [NSString stringWithFormat:@"<a href=\"%@\"><img src=\"%@\"/></a>", self.hrefUrl, self.srcUrl];
}

//////////////////////////////////////////////////////////////
#pragma mark - Public methods
//////////////////////////////////////////////////////////////

- (NSURL *)srcUrl
{
    return [NSURL URLWithString:[m_dictionary objectForKey:@"src"]];
}

- (NSURL *)hrefUrl
{
    return [NSURL URLWithString:[m_dictionary objectForKey:@"href"]];
}

@end
