//
//  ForgetPwdViewController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "ForgetPwdViewController.h"

@interface ForgetPwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCode:(id)sender {
    [LoanApi getCodeWithMobile:_mobileTF.text type:@"resetCode" finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if (success&&errorCode==200) {
             [self showHudTitle:@"获取验证码成功" delay:1];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }
    }];
}

- (IBAction)resetPwd:(id)sender {
    [LoanApi resetPwdWithMobile:_mobileTF.text pwd:_pwdTF.text code:_codeTF.text finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if(success&&errorCode==200){
            [self showHudTitle:@"修改密码成功" delay:1];
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
