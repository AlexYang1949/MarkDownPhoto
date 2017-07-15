//
//  LoginController.h
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^loginBlock)(NSString *mobile,NSString *token);
@interface LoginController : BaseViewController
@property (nonatomic , copy) loginBlock block;
@end
