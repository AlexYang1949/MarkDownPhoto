//
//  LoginController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoginController.h"
#import "ForgetPwdViewController.h"
#import "RegistController.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavLeftButtonwithImg:@"backNavItem" selImg:@"backNavItem" title:nil action:@selector(back)];
}

- (void)back{
   [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forgetPwdClick:(id)sender {
    ForgetPwdViewController *forgetPwdVc = [self getViewController:@"ForgetPwdViewController" onStoryBoard:@"Mine"];
    forgetPwdVc.block = _block;
    [self.navigationController pushViewController:forgetPwdVc animated:YES];
}
- (IBAction)registClick:(id)sender {
    RegistController *RegistVc = [self getViewController:@"RegistController" onStoryBoard:@"Mine"];
    RegistVc.block = _block;
    [self.navigationController pushViewController:RegistVc animated:YES];
}
- (IBAction)lognClick:(id)sender {
    if (ISNULL(_mobileTF.text)){
        return;
    }
    [LoanApi loginWithMobile:_mobileTF.text pwd:[_pwdTF.text md5] finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if(success&&errorCode==200){
            [self showHudTitle:@"登录成功" delay:1];
            if (_block) {
                _block(resultObj[@"result"][@"mobile"],resultObj[@"result"][@"token"]);
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }
    }];
    
}

@end
