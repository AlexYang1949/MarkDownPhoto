//
//  LoanApi.h
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/11.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface LoanHTTPManager : AFHTTPSessionManager
+ (instancetype)sharedManager;
@end


typedef void(^finishBlock)(BOOL success,NSDictionary * resultObj, NSError *error);
@interface LoanApi : NSObject
+ (instancetype)sharedInstance;

// 首页
+ (void)getAdImagePageNum:(NSUInteger)pageNum Size:(NSUInteger)size finish:(finishBlock)finished;
+ (void)getHotPageNum:(NSUInteger)pageNum Size:(NSUInteger)size finish:(finishBlock)finished;

// 贷款
+ (void)getLoanListPageNum:(NSUInteger)pageNum Size:(NSUInteger)size finish:(finishBlock)finished;
+ (void)getLoanDetailId:(NSString *)Id finish:(finishBlock)finished;

// 信用卡
+ (void)getBankListPageNum:(NSUInteger)pageNum Size:(NSUInteger)size finish:(finishBlock)finished;
+ (void)getCreditWithBankId:(NSString *)bankId finish:(finishBlock)finished;
+ (void)getCreditDetailId:(NSString *)bankId finish:(finishBlock)finished;

@end
