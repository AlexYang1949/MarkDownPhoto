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
    [self.navigationController pushViewController:forgetPwdVc animated:YES];
}
- (IBAction)registClick:(id)sender {
    RegistController *RegistVc = [self getViewController:@"RegistController" onStoryBoard:@"Mine"];
    [self.navigationController pushViewController:RegistVc animated:YES];
}
- (IBAction)lognClick:(id)sender {
    if (ISNULL(_mobileTF.text)){
        return;
    }
    [LoanApi loginWithMobile:_mobileTF.text pwd:_pwdTF.text finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        if(success){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
}

@end
