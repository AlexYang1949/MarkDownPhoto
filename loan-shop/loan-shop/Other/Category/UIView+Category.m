//
//  UIView+Category.m
//  hqdIphone
//
//  Created by haoqidai on 15/4/23.
//  Copyright (c) 2015年 CoderBook. All rights reserved.
//

#import "UIView+Category.h"


@implementation UIView (Category)
- (float)minX
{
    return CGRectGetMinX(self.frame);
}

- (float)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (float)minY
{
    return CGRectGetMinY(self.frame);
}

- (float)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (float)width
{
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (float)height
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat )x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat )y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end




