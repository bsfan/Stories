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
