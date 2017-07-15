//
//  FakeResultController.m
//  loan-shop
//
//  Created by yangzhaoheng on 2017/7/8.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "FakeResultController.h"

@interface FakeResultController ()

@end

@implementation FakeResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavLeftButtonwithImg:nil selImg:nil title:@"" action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)makeSure:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
