//
//  LoanApi.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/11.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoanApi.h"

#define BaseUrlStr @"http://qufankui.com/siteapi"
@implementation LoanHTTPManager

+ (instancetype)sharedManager{
    static LoanHTTPManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = (LoanHTTPManager *)[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrlStr]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 30;
    });
    return manager;
}

@end

@implementation LoanApi
+ (instancetype)sharedInstance{
    static LoanApi *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
        
    });
    return sharedInstance;
}


+ (void)getAdImagePageNum:(NSUInteger)pageNum Size:(NSUInteger)size finish:(finishBlock)finished
{
    NSDictionary *parameters =@{@"pageNum":@(pageNum),
                                @"size":@(size)};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"screen/ad" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSError *error = nil;
         id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         if (finished==nil) {
             return;
         }
         if (ISNULL(obj)) {
             finished(YES, nil, nil);
         }else{
             finished(YES, obj, nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         finished(NO,nil,error);
     }];
}

+ (void)getHotPageNum:(NSUInteger)pageNum Size:(NSUInteger)size finish:(finishBlock)finished{
    NSDictionary *parameters =@{@"pageNum":@(pageNum),
                                @"size":@(size)};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"screen/hot" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSError *error = nil;
         id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         if (finished==nil) {
             return;
         }
         if (ISNULL(obj)) {
             finished(YES, nil, nil);
         }else{
             finished(YES, obj, nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         finished(NO,nil,error);
     }];
}

+(void)getLoanListPageNum:(NSUInteger)pageNum Size:(NSUInteger)size finish:(finishBlock)finished{
    NSDictionary *parameters =@{@"pageNum":@(pageNum),
                                @"size":@(size)};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"loan/find" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSError *error = nil;
         id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         if (finished==nil) {
             return;
         }
         if (ISNULL(obj)) {
             finished(YES, nil, nil);
         }else{
             finished(YES, obj, nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         finished(NO,nil,error);
     }];
}

+(void)getLoanDetailId:(NSString *)Id finish:(finishBlock)finished{
    NSDictionary *parameters =@{@"id":Id};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"loan/detail" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSError *error = nil;
         id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         if (finished==nil) {
             return;
         }
         if (ISNULL(obj)) {
             finished(YES, nil, nil);
         }else{
             finished(YES, obj, nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         finished(NO,nil,error);
     }];
}

+(void)getBankListPageNum:(NSUInteger)pageNum Size:(NSUInteger)size finish:(finishBlock)finished{
    NSDictionary *parameters =@{@"pageNum":@(pageNum),
                                @"size":@(size)};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"bank/find" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSError *error = nil;
         id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         if (finished==nil) {
             return;
         }
         if (ISNULL(obj)) {
             finished(YES, nil, nil);
         }else{
             finished(YES, obj, nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         finished(NO,nil,error);
     }];
}

+ (void)getCreditWithBankId:(NSString *)bankId finish:(finishBlock)finished{
    NSDictionary *parameters =@{@"bankId":bankId};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"bank/credit" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSError *error = nil;
         id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         if (finished==nil) {
             return;
         }
         if (ISNULL(obj)) {
             finished(YES, nil, nil);
         }else{
             finished(YES, obj, nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         finished(NO,nil,error);
     }];
}

+(void)getCreditDetailId:(NSString *)bankId finish:(finishBlock)finished{
    NSDictionary *parameters =@{@"id":bankId};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"bank/credit/detail" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSError *error = nil;
         id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
         if (finished==nil) {
             return;
         }
         if (ISNULL(obj)) {
             finished(YES, nil, nil);
         }else{
             finished(YES, obj, nil);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         finished(NO,nil,error);
     }];

}
@end
