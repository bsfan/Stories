//
//  StoryView.h
//  Stories
//
//  Created by Francois Lambert on 11-07-16.
//  Copyright 2011 Mirego, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Story;

@interface StoryView : UIView
{
    Story* m_story;
    UIWebView* m_webView;
}

- (id)initWithFrame:(CGRect)frame story:(Story *)story;

@end
