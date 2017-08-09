//
//  AppDelegate.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "FakeHomeController.h"
#import "BaseNavController.h"
#import "UMessage.h"
#import "UMMobClick/MobClick.h"
#import "WebController.h"
#import "BaseErrorController.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:@"597043fa734be44a90001641" launchOptions:launchOptions];
    [UMessage registerForRemoteNotifications];
    [UMessage setLogEnabled:YES];
    [UMessage openDebugMode:YES];
    
    // 配置统计
    UMConfigInstance.appKey = @"597043fa734be44a90001641";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self handleFake];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networking:) name:@"Networking" object:nil];
    
    return YES;
}

- (void)networking:(NSNotification *)notify{
}

- (void)handleFake{
    [LoanApi handleFakefinish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        if (success) {
            // 伪页面
            if([resultObj[@"result"] integerValue] ==1){
                FakeHomeController *fakeVc = [[UIStoryboard storyboardWithName:@"Fake" bundle:nil] instantiateViewControllerWithIdentifier:@"FakeHomeController"];
                BaseNavController *fakeNav = [[BaseNavController alloc] initWithRootViewController:fakeVc];
                self.window.rootViewController = fakeNav;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"fake"];
            }else{
                self.window.rootViewController = [MainTabBarController sharedInstance];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"fake"];
            }
        }
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self handleFake];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (self.window.rootViewController==nil) {
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Base" bundle:nil] instantiateViewControllerWithIdentifier:@"BaseErrorController"];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    [UMessage didReceiveRemoteNotification:userInfo];
    //iOS10以下使用这个方法接收通知
    if (!ISNULL(userInfo)) {
        NSString *openUrl=userInfo[@"openUrl"];
        if (openUrl) {
            [self openHTML:openUrl];
        }
    }
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
        if (!ISNULL(userInfo)) {
            NSString *openUrl=userInfo[@"openUrl"];
            if (openUrl) {
                [self openHTML:openUrl];
            }
        }
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        if (!ISNULL(userInfo)) {
            NSString *openUrl=userInfo[@"openUrl"];
            if (openUrl) {
                [self openHTML:openUrl];
            }
        }
        
    }else{
        //应用处于后台时的本地推送接受
    }
}

- (void)openHTML:(NSString *)url{
    WebController *webVc = [[UIStoryboard storyboardWithName:@"Base" bundle:nil] instantiateViewControllerWithIdentifier:@"WebController"];
    webVc.urlStr = url;
    [[self currentViewController].navigationController pushViewController:webVc animated:YES];

}

//获取Window当前显示的ViewController
- (UIViewController*)currentViewController{
    UIViewController* vc = self.window.rootViewController;
    
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
        
    }
    
    return vc;
}


@end
