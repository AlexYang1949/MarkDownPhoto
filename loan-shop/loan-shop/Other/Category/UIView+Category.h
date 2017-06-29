//
//  UIView+Category.h
//  hqdIphone
//
//  Created by haoqidai on 15/4/23.
//  Copyright (c) 2015年 CoderBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
- (float)minX;
- (float)maxX;
- (float)minY;
- (float)maxY;
- (float)width;
- (float)height;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x;
- (CGFloat)x;
- (CGFloat)y ;
- (void)setY:(CGFloat)y;

+ (id)loadFromNib;
+ (id)loadFromNibNamed:(NSString*) nibName;
+ (id)loadFromNibNoOwner;

@end
