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
