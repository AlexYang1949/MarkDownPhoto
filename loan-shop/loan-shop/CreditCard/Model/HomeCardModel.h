//
//  HomeCard.h
//  loan-shop
//
//  Created by Alex yang on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCardModel : NSObject
@property (nonatomic , strong) NSString *id;
@property(nonatomic ,strong) NSString *name;
@property(nonatomic ,strong) NSString *remark;
@property(nonatomic ,strong) NSString *iconShowUrl;
@property(nonatomic ,strong) NSString *link;
@property(nonatomic ,strong) NSString *progress;
@property(nonatomic ,strong) NSString *applyCount;
@end
