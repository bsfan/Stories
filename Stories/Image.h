//
//  Image.h
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
{
    NSDictionary* m_dictionary;
    NSString* m_html;
}

@property (nonatomic, readonly) NSURL* srcUrl;
@property (nonatomic, readonly) NSURL* hrefUrl;

@property (nonatomic, readonly) NSString* html;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
