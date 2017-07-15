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
        if (success) {
            
        }
    }];
}

- (IBAction)resetPwd:(id)sender {
    [LoanApi resetPwdWithMobile:_mobileTF.text pwd:_pwdTF.text code:_codeTF.text finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        
    }];
}



@end
