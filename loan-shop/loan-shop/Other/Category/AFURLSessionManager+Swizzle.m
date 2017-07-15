//
//  AFURLSessionManager+Swizzle.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/14.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "AFURLSessionManager+Swizzle.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <libkern/OSAtomic.h>
typedef void (^successBlock)(NSURLSessionDataTask * _Nonnull, id _Nullable);
typedef void (^failureBlock)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);
@implementation AFURLSessionManager (Swizzle)
+(void)load{
    [self methodSwizzlingWithOriginalSelector:@selector(POST:parameters:progress:success:failure:) bySwizzledSelector:@selector(sw_POST:parameters:progress:success:failure:)];
    [self methodSwizzlingWithOriginalSelector:@selector(GET:parameters:progress:success:failure:) bySwizzledSelector:@selector(sw_GET:parameters:progress:success:failure:)];
}
- (NSURLSessionDataTask *)sw_POST:(NSString *)URLString
                       parameters:(id)parameters
                         progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                          success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                          failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    successBlock successBlock = ^(NSURLSessionDataTask * task, id response){
        
        success(task,response);
    };
    
    failureBlock failureBlock = ^(NSURLSessionDataTask * task, NSError *error){
        
        failure(task,error);
    };
    return  [self sw_POST:URLString parameters:parameters progress:uploadProgress success:successBlock failure:failureBlock];
}

- (NSURLSessionDataTask *)sw_GET:(NSString *)URLString
                      parameters:(id)parameters
                        progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                         success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    successBlock successBlock = ^(NSURLSessionDataTask * task, id response){
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        if (!ISNULL(obj)&&[obj isKindOfClass:[NSDictionary class]]) {
            NSUInteger errorCode = [obj[@"errorCode"] integerValue];
            NSString *errorMessage = obj[@"errorMessage"];
            if (errorCode!=200) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Networking" object:errorMessage];
            }
        }
        success(task,response);
    };
    
    failureBlock failureBlock = ^(NSURLSessionDataTask * task, NSError *error){
        
        failure(task,error);
    };
    return [self sw_GET:URLString parameters:parameters progress:downloadProgress success:successBlock failure:failureBlock];
}

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector{
    swizz_performLocked(^{
        Class class = [self class];
        //原有方法
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        //替换原有方法的新方法
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
        BOOL didAddMethod = class_addMethod(class,originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {//添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
            class_replaceMethod(class,swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {//添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

static void swizz_performLocked(dispatch_block_t block) {
    static OSSpinLock aspect_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&aspect_lock);
    block();
    OSSpinLockUnlock(&aspect_lock);
}


@end
