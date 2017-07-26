//
//  WebController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "WebController.h"
#import "RareModel.h"
@interface WebController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"跳转网页";
    if (!ISNULL(_urlStr)) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    }else if(!ISNULL(_rareId)){
        [self setupData];
    }else if(!ISNULL(_content)) {
        [_webView loadHTMLString:_content baseURL:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getRareDetailWithId:_rareId finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        RareModel *model = [RareModel mj_objectWithKeyValues:resultObj[@"result"]];
        [_webView loadHTMLString:model.content baseURL:nil];
    }];
}



@end
