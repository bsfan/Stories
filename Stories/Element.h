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


@class Author, Image;

@interface Element : NSObject {
    NSString *_source;
    NSString *_elementClass;
    NSURL *_permalinkURL;
    NSString *_title;
    NSString *_description;
    NSURL *_thumbnailURL;
    NSURL *_faviconURL;
    Author *_author;
    NSDate *_creationDate;
    NSDate *_additionDate;
    NSString *_oembed;
    Image *_image;
}

@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSString *elementClass;
@property (nonatomic, retain) NSURL *permalinkURL;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSURL *thumbnailURL;
@property (nonatomic, retain) NSURL *faviconURL;
@property (nonatomic, retain) Author *author;
@property (nonatomic, retain) NSDate *creationDate;
@property (nonatomic, retain) NSDate *additionDate;
@property (nonatomic, retain) NSString *oembed;
@property (nonatomic, retain) Image *image;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)HTML;

@end