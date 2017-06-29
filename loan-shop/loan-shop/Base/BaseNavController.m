//
//  BaseNavController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "BaseNavController.h"
#import "UIImage+Additional.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[BaseNavController class], nil];
    UIImage * image = nil;

    image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(MAIN_BOUNDS_WIDTH, 128)];

    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    NSDictionary *attr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:19.0f], NSForegroundColorAttributeName: [UIColor colorWithWhite:0.141 alpha:1.000]};
    [navBar setTitleTextAttributes:attr];
    [navBar setTintColor:[UIColor colorWithWhite:0.141 alpha:1.000]];
}

#pragma mark 控制状态颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
