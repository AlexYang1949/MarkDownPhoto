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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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
            if([resultObj[@"result"] integerValue]!=1){
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
        self.window.rootViewController = [[UIViewController alloc] init];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
