//
//  RareBookController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/4.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "RareBookController.h"

@interface RareBookController ()

@end

@implementation RareBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"秘籍";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectTop:(UIButton *)sender {
    for (UIView *view in self.view.subviews) {
        if ([view isEqual:sender]) {
            [sender setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
        }else if([view isKindOfClass:[UIButton class]]){
            [sender setTitleColor:COLORHEX(0xB8B8B8) forState:UIControlStateNormal];
        }
    }
}


@end
