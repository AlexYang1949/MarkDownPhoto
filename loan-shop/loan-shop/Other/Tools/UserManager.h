//
//  UserManager.h
//  loan-shop
//
//  Created by yangzhaoheng on 2017/7/16.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject
+ (NSString *)currentUser;
+ (void)saveUser:(NSString *)mobile;
@end
