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

#import "StoryView.h"
#import "Story.h"

@implementation StoryView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame story:nil];
}

- (id)initWithFrame:(CGRect)frame story:(Story *)story;
{
    self = [super initWithFrame:frame];
    if (self) {
        m_story = [story retain];
        m_webView = [[[UIWebView alloc] initWithFrame:self.frame] retain];
        [m_webView loadHTMLString:[story HTML] baseURL:nil];
        [m_webView setDelegate:self];
        
        [self addSubview:m_webView];
    }
    return self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)dealloc
{
    [m_webView removeFromSuperview];
    [m_webView release];
    [m_story release];
    [self dealloc];
}

//////////////////////////////////////////////////////////////
#pragma mark
//////////////////////////////////////////////////////////////

- (void)layoutSubviews
{
}

@end
