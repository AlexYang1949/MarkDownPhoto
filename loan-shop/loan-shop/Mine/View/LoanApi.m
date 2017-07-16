//
//  LoanApi.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/11.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoanApi.h"
#import "NSString+Additional.h"
#define BaseUrlStr @"http://app.zboat.cn/siteapi"
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

+(void)handleFakefinish:(finishBlock)finished{
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"screen/mock" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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

// 登录注册
+ (void)registerWithMobile:(NSString *)mobile pwd:(NSString *)pwd code:(NSString *)code finish:(finishBlock)finished{
    NSTimeInterval cur_time = [[NSDate date] timeIntervalSince1970];
    NSString *sign = [[NSString stringWithFormat:@"%f%@%@",cur_time,mobile,@"market"] md5];
    NSDictionary *parameters = @{@"mobile":mobile,
                                 @"password":pwd,
                                 @"code":code,
                                 @"sign":sign,
                                 @"tm":[NSString stringWithFormat:@"%f",cur_time]};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"app/register" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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
+ (void)loginWithMobile:(NSString *)mobile pwd:(NSString *)pwd finish:(finishBlock)finished{
    NSTimeInterval cur_time = [[NSDate date] timeIntervalSince1970];
    NSString *sign = [[NSString stringWithFormat:@"%f%@%@",cur_time,mobile,@"market"] md5];
    NSDictionary *parameters = @{@"mobile":mobile,
                                 @"password":pwd,
                                 @"sign":sign,
                                 @"tm":[NSString stringWithFormat:@"%f",cur_time]};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"app/login" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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
+ (void)resetPwdWithMobile:(NSString *)mobile pwd:(NSString *)pwd code:(NSString *)code finish:(finishBlock)finished{
    NSTimeInterval cur_time = [[NSDate date] timeIntervalSince1970];
    NSString *sign = [[NSString stringWithFormat:@"%f%@%@",cur_time,mobile,@"market"] md5];
    NSDictionary *parameters = @{@"mobile":mobile,
                                 @"password":pwd,
                                 @"sign":sign,
                                 @"tm":[NSString stringWithFormat:@"%f",cur_time],
                                 @"code":code};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"app/reset" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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

+ (void)getCodeWithMobile:(NSString *)mobile type:(NSString *)type finish:(finishBlock)finished{
    NSTimeInterval cur_time = [[NSDate date] timeIntervalSince1970];
    NSString *sign = [[NSString stringWithFormat:@"%f%@%@",cur_time,mobile,@"market"] md5];
    NSDictionary *parameters = @{@"mobile":mobile,
                                 @"sign":sign,
                                 @"tm":[NSString stringWithFormat:@"%f",cur_time]};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    NSString *urlStr = [NSString stringWithFormat:@"app/%@",type];
    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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

// 秘籍
+ (void)getRareListWithId:(NSString *)tabId finish:(finishBlock)finished{
    NSDictionary *parameters = @{@"tabId":tabId};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"tab/news" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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
+ (void)getRareDetailWithId:(NSString *)rareId finish:(finishBlock)finished{
    NSDictionary *parameters = @{@"id":rareId};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"tab/news/detail" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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

+ (void)getHistoryWithMobile:(NSString *)mobile type:(NSString *)type finish:(finishBlock)finished{
    NSDictionary *parameters = @{@"mobile":mobile,
                                 @"type":type};
    LoanHTTPManager *manager = [LoanHTTPManager sharedManager];
    [manager POST:@"screen/record/history" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
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
