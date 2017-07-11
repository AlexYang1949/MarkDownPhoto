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


typedef void(^finishBlock)(BOOL success,id resultObj, NSError *error);
@interface LoanApi : NSObject
+ (instancetype)sharedInstance;

+ (void)getAdImagePageNum:(NSUInteger)pageNum Size:(NSUInteger)size finish:(finishBlock)finished;
@end
