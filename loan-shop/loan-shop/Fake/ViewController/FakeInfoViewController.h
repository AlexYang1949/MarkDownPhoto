//
//  FakeInfoViewController.h
//  loan-shop
//
//  Created by Alex yang on 2017/7/5.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "BaseViewController.h"
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
#define PICKERVIEW_HEIGHT   250
@interface FakeInfoViewController : BaseViewController
{
    UIButton *button;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
}
@property (nonatomic , strong) NSArray *titleArray;
@property (nonatomic , assign) NSUInteger index;
@end
