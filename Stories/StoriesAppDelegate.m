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

#import "StoriesAppDelegate.h"
#import "SearchViewController.h"

#import "JSONKit.h"
#import "Story.h"

@implementation StoriesAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [searchViewController release];
    
    [[self window] setRootViewController:navigationController];
    [navigationController release];
    
    // DEBUG
//    NSString* storyJson = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"new-story3" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
//    NSDictionary* storyDictionary = [storyJson objectFromJSONString];
//    Story* story = [[[Story alloc] initWithDictionary:storyDictionary] autorelease];
//    NSLog(@"%@", story.html);
    // DEBUG

    [[self window] makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)dealloc {
    [_window release];
    [super dealloc];
}

@end