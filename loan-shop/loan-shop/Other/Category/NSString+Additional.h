//
//  NSString+Additional.h
//  
//
//  Created by 家伟 李 on 15/4/8.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additional)

/**
 * Returns the MD5 value of the string
 */
- (NSString*)md5;
/**
 *  是否是包含空格的字符串
 *
 *  @return BOOL Value
 */
- (BOOL)isEmptyOrWhitespace;
- (NSString *)encodingURL;

/**
 *  是否是字符串为空
 *  
 *  @param str 为空字符串或不是字符串对象时返回YES
 *  @return BOOL Value
 */
+ (BOOL)checkEmptyString:(NSString *)str;

- (BOOL)isEmpty;
@end
