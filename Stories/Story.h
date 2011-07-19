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

@interface Story : NSObject {
    NSURL *_permalinkURL;
    NSURL *_permalinkJSONURL;
    NSDate *_publicationDate;
    Author *_author;
    NSURL *_shortURL;
    NSString *_title;
    NSString *_description;
    NSURL *_thumbnailURL;
    NSArray *_topics;
    NSArray *_elements;
}

@property (nonatomic, retain) NSURL *permalinkURL;
@property (nonatomic, retain) NSURL *permalinkJSONURL;
@property (nonatomic, retain) NSDate *publicationDate;
@property (nonatomic, retain) Author *author;
@property (nonatomic, retain) NSURL *shortURL;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSURL *thumbnailURL;
@property (nonatomic, retain) NSArray *topics;
@property (nonatomic, retain) NSArray *elements;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)HTML;

@end