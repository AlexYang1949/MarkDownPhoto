//
//  MainTabBarController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "LoanController.h"
#import "CreditCardController.h"
#import "MineController.h"
#import "BaseNavController.h"
#import "MainTabBar.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

+(instancetype)sharedInstance {
    static MainTabBarController *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         shareInstance = [[self alloc] init];
    });
    return shareInstance;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildVcs];
    MainTabBar *tabBar = [[MainTabBar alloc] initWithFrame:CGRectMake(0, 0, MAIN_BOUNDS_WIDTH, 49)];
    tabBar.translucent = NO;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}
- (void)addAllChildVcs
{
    
    HomeViewController *liveVC = [self getViewController:@"HomeViewController" onStoryBoard:@"Main"];
    
    [self addOneChlildVc:liveVC title:@"首页" imageName:@"fuwu" selectedImageName:@"fuwu_select"];
    
    LoanController *loanVc = [self getViewController:@"LoanController" onStoryBoard:@"Loan"];
    
    [self addOneChlildVc:loanVc title:@"贷款" imageName:@"fuwu" selectedImageName:@"fuwu_select"];
    
    CreditCardController *creditCardVc = [self getViewController:@"CreditCardController" onStoryBoard:@"CreditCard"];
    
    [self addOneChlildVc:creditCardVc title:@"信用卡" imageName:@"fuwu" selectedImageName:@"fuwu_select"];
    
    MineController *mineVC = [self getViewController:@"MineController" onStoryBoard:@"Mine"];
    
    [self addOneChlildVc:mineVC title:@"我的" imageName:@"fuwu" selectedImageName:@"fuwu_select"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0xa8a7a7);
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = kNavBackGround;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];

        // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
}
-(id)getViewController:(NSString*)controllName onStoryBoard:(NSString*)boardName {
    return [[UIStoryboard storyboardWithName:boardName bundle:nil] instantiateViewControllerWithIdentifier:controllName];
    
}

@end