//
//  RegistController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "RegistController.h"

@interface RegistController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCode:(id)sender {
    if (ISNULL(_mobileTF.text)) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getCodeWithMobile:_mobileTF.text type:@"regCode" finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        if (!success) {
            [self showHudTitle:@"网络错误！" delay:1];
            return ;
        }
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if(success&&errorCode==200){
            [self showHudTitle:@"获取验证码成功" delay:1];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }
    }];
}

// 注册
- (IBAction)regClick:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi registerWithMobile:_mobileTF.text pwd:_pwdTF.text code:_codeTF.text finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if(success&&errorCode==200){
            [self showHudTitle:@"注册成功" delay:1];
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
