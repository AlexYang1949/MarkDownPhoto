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
    [LoanApi getCodeWithMobile:_mobileTF.text type:@"regCode" finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        
    }];
}

// 注册
- (IBAction)regClick:(id)sender {
    [LoanApi resetPwdWithMobile:_mobileTF.text pwd:_pwdTF.text code:_codeTF.text finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        if (success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }];
}

@end
