//
//  Story.h
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
#import "Element.h"

@interface Story : NSObject
{
    NSDictionary* m_dictionary;
    Author* m_author;
    NSMutableArray* m_editors;
    NSMutableArray* m_topicsUrl;
    NSMutableArray* m_elements;
//    Stats* m_stats;
}

@property (nonatomic, readonly) NSURL* permalinkUrl;
@property (nonatomic, readonly) NSDate* publishedAt;
@property (nonatomic, readonly) Author* author;
@property (nonatomic, readonly) NSArray* editors;
@property (nonatomic, readonly) NSURL* shortUrl;
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* description;
@property (nonatomic, readonly) NSURL* thumbnailUrl;
@property (nonatomic, readonly) NSArray* topicsUrl;
@property (nonatomic, readonly) NSArray* elements;
//@property (nonatomic, readonly) Stats* stats;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
