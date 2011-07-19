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


@interface Image : NSObject {
    NSURL *_sourceURL;
    NSURL *_linkURL;
    NSString *_width;
    NSString *_height;
}

@property (nonatomic, retain) NSURL *sourceURL;
@property (nonatomic, retain) NSURL *linkURL;
@property (nonatomic, retain) NSString *width;
@property (nonatomic, retain) NSString *height;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)HTML;

@end