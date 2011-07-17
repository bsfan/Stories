//
//  Element.h
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Author;
@class Image;

@interface Element : NSObject
{
    NSDictionary* m_dictionary;
    Author* m_author;
    Image* m_image;
    NSString* m_html;
}

//@property (nonatomic, readonly) Editor* editor;
@property (nonatomic, readonly) NSString* source;
@property (nonatomic, readonly) NSString* elementClass;
@property (nonatomic, readonly) NSURL* permalinkUrl;
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* description;
@property (nonatomic, readonly) NSURL* thumbnailUrl;
@property (nonatomic, readonly) NSURL* favIconUrl;
@property (nonatomic, readonly) Author* author;
@property (nonatomic, readonly) NSDate* createdAt;
@property (nonatomic, readonly) NSDate* addedAt;
@property (nonatomic, readonly) NSString* oEmbedHtml;
@property (nonatomic, readonly) Image* image;

@property (nonatomic, readonly) NSString* html;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
