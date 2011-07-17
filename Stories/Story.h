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

@interface Story : NSObject
{
    NSDictionary* m_dictionary;
    Author* m_author;
    NSMutableArray* m_editors;
    NSMutableArray* m_topicsUrl;
    NSMutableArray* m_elements;
//    Stats* m_stats;
    NSString* m_html;
}

@property (nonatomic, readonly) NSURL* permalinkUrl;
@property (nonatomic, readonly) NSURL* permalinkJsonUrl; // Use this to load the story content
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

@property (nonatomic, readonly) NSString* html;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
