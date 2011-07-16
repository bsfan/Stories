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
    }
    return self;
}

- (void)dealloc
{
    [m_story release];
    [self dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
