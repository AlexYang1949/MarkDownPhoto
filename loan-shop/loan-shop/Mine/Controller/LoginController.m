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

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
