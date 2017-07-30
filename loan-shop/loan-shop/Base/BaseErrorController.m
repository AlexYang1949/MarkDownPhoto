//
//  BaseErrorController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/27.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "BaseErrorController.h"

@interface BaseErrorController ()
@property (weak, nonatomic) IBOutlet UILabel *tipView;
@property (nonatomic , strong) MBProgressHUD *hud;

@end

@implementation BaseErrorController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_tipView!=nil) {
            [_hud hideAnimated:YES];
            _tipView.text = @"请检查网络连接后重试";
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
