//
//  LoanDetailModel.h
//  loan-shop
//
//  Created by Alex yang on 2017/7/3.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanDetailModel : NSObject
@property (nonatomic , strong) NSString *id;
@property(nonatomic ,strong) NSString *name;
@property(nonatomic ,strong) NSString *link;
@property(nonatomic ,strong) NSString *iconShowUrl;
@property(nonatomic ,strong) NSString *leadingSpeed;
@property(nonatomic ,strong) NSString *instructions;
@property(nonatomic ,strong) NSString *limitation;
@property(nonatomic ,strong) NSString *material;
@property(nonatomic ,strong) NSString *orgName;
@property(nonatomic ,strong) NSString *paymentMode;
@property(nonatomic ,strong) NSString *rate;
@property(nonatomic ,strong) NSString *remark;
@property(nonatomic ,strong) NSString *requirement;
@property(nonatomic ,strong) NSString *term;
@property (nonatomic , strong) NSString *applyCount;
@property (nonatomic , assign) BOOL yn;
@property (nonatomic , assign) BOOL nw;


@end
