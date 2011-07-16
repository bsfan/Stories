//
//  Author.h
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject
{
    NSDictionary* m_dictionary;
}

@property (nonatomic, readonly) NSString* username;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSURL* avatarUrl;
@property (nonatomic, readonly) NSString* description;
@property (nonatomic, readonly) NSString* location;
@property (nonatomic, readonly) NSString* website;
@property (nonatomic, readonly) NSURL* permalinkUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
