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


@implementation Image

@synthesize sourceURL=_sourceURL;
@synthesize linkURL=_linkURL;
@synthesize width=_width;
@synthesize height=_height;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        id src = [dictionary objectForKey:@"src"];
        if (src && [src isKindOfClass:[NSString class]]) {
            [self setSourceURL:[NSURL URLWithString:src]];
        }
        id href = [dictionary objectForKey:@"href"];
        if (href && [href isKindOfClass:[NSString class]]) {
            [self setLinkURL:[NSURL URLWithString:href]];
        }
        id width = [dictionary objectForKey:@"width"];
        if (width && [width isKindOfClass:[NSString class]]) {
            [self setWidth:width];
        }
        id height = [dictionary objectForKey:@"height"];
        if (height && [height isKindOfClass:[NSString class]]) {
            [self setHeight:height];
        }
    }
    
    return self;
}

- (NSString *)HTML {
    NSMutableString *output = [[NSMutableString alloc] init];
    
    if (_linkURL) {
        [output appendFormat:@"<a href=\"%@\">", [self linkURL]];
    }
    [output appendFormat:@"<img src=\"%@\" alt=\"\"/>", [self sourceURL]];
    if (_linkURL) {
        [output appendString:@"</a>"];
    }
    
    return [output autorelease];
}


#pragma mark -

- (void)dealloc {
    [_linkURL release];
    [_sourceURL release];
    
    [super dealloc];
}

@end