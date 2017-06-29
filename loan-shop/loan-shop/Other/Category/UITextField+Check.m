//
//  UITextField+Check.m
//  zhulebei
//
//  Created by 小强 on 15/9/25.
//  Copyright (c) 2015年 haoqidai. All rights reserved.
//

#import "UITextField+Check.h"

@implementation UITextField (Check)


// 判断输入是否是以1开头的
-(BOOL)isMatch {
    
    NSString *_phoneNum = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *regex = @"^1\\d{10}$";
    
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([_phoneNum length] == 11 && [pred evaluateWithObject:_phoneNum]) {
        
        return YES;
    }
    
    return NO;
    
}

@end
