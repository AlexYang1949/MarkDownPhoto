//
//  Config.h
//  loan-shop
//
//  Created by Alex yang on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define MAIN_BOUNDS_HEIGHT   ([UIScreen mainScreen].bounds).size.height //屏幕的高度
#define MAIN_BOUNDS_WIDTH    ([UIScreen mainScreen].bounds).size.width //屏幕的宽度
#define HEIGHT_TITLE 30

#define HEIGHT_CELL 80

#define HEIGHT_BANNER 130

#define COLORHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_MAIN COLORHEX(0x267cef)
#define COLOR_BACK COLORHEX(0xf6f6f6)
#define COLOR_GRAY COLORHEX(0x555555)

// 常用define
#define ISNULL(val) (val==nil || (NSNull*)val== [NSNull null])

#import "LoanApi.h"
#import "MJExtension.h"
#import "LoanDetailModel.h"
#import "HomeCardModel.h"
#import "MBProgressHUD.h"
#import "UserManager.h"
#import "NSString+Additional.h"

#endif /* Config_h */
