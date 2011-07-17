//
//  StoryView.m
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import "StoryView.h"

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
        
//        NSString* HTMLString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"new-story3" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
//        [m_webView loadHTMLString:HTMLString baseURL:nil];
        
        [self addSubview:m_webView];
    }
    return self;
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
