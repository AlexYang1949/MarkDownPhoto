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
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

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
    if (ISNULL(_mobileTF.text)||[_mobileTF.text isEqualToString:@""]){
        [self showHudTitle:@"请填写手机号" delay:1.0];
        return;
    }
    [LoanApi getCodeWithMobile:_mobileTF.text type:@"resetCode" finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        if (!success) {
            [self showHudTitle:@"请检查网络连接后重试！" delay:1];
            return ;
        }
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if (success&&errorCode==200) {
            [self timerFireMethod];
             [self showHudTitle:@"获取验证码成功" delay:1];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }
    }];
}

- (IBAction)resetPwd:(id)sender {
    if (ISNULL(_mobileTF.text)||[_mobileTF.text isEqualToString:@""]){
        [self showHudTitle:@"请填写手机号" delay:1.0];
        return;
    }
    if (ISNULL(_pwdTF.text)||[_pwdTF.text isEqualToString:@""]){
        [self showHudTitle:@"请填写密码" delay:1.0];
        return;
    }
    if (ISNULL(_codeTF.text)||[_codeTF.text isEqualToString:@""]){
        [self showHudTitle:@"请填写验证码" delay:1.0];
        return;
    }

    [LoanApi resetPwdWithMobile:_mobileTF.text pwd:[_pwdTF.text md5] code:_codeTF.text finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        if (!success) {
            [self showHudTitle:@"请检查网络连接后重试！" delay:1];
            return ;
        }
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

#pragma mark 60秒倒计时
-(void)timerFireMethod
{
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_getCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                _getCodeButton.userInteractionEnabled = YES;
                
            });
            
        }else{
            int seconds = timeout % 60 == 0 ? 60: timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                _getCodeButton.titleLabel.text = @"";
                [_getCodeButton  setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                _getCodeButton.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}


@end
