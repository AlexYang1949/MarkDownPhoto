//
//  Config.h
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define MAIN_BOUNDS_HEIGHT   ([UIScreen mainScreen].bounds).size.height //屏幕的高度
#define MAIN_BOUNDS_WIDTH    ([UIScreen mainScreen].bounds).size.width //屏幕的宽度

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kNavBackGround [UIColor colorWithRed:0.541 green:0.635 blue:0.741 alpha:1.000]
#define MAIN_COLOR [UIColor colorWithRed:0.243 green:0.557 blue:0.933 alpha:1.000]
#endif /* Config_h */
