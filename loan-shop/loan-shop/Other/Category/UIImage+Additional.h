//
//  UIImage+Additional.h
//  
//
//  Created by Bob on 15/4/10.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additional)
/**
 *  @brief 通过色值生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/*
 *  extend stretchableImageWithLeftCapWidth:topCapHeight on ios5++
 *
 *  on ios4 make sure your capInsets's left as stretchableImageWithLeftCapWidth:topCapHeight 's width and capInsets'top as stretchableImageWithLeftCapWidth:topCapHeight 's height
 *  on ios5&ios5++ like call resizableImageWithCapInsets:
 */
- (UIImage *)resizableImageExtendWithCapInsets:(UIEdgeInsets)capInsets;


/*
 * Creates an image from the contents of a URL
 */
+ (UIImage*)imageWithContentsOfURL:(NSURL*)url;

/*
 * Scales the image to the given size
 */
- (UIImage*)scaleToSize:(CGSize)size;
@end
