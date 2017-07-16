//
//  UserManager.m
//  loan-shop
//
//  Created by yangzhaoheng on 2017/7/16.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
+ (NSString *)currentUser{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
}

+ (void)saveUser:(NSString *)mobile{
    [[NSUserDefaults standardUserDefaults] setObject:mobile forKey:@"user"];
}
@end
