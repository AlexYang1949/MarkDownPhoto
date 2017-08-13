//
//  LoanWebCell.m
//  loan-shop
//
//  Created by yangzhaoheng on 2017/8/12.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoanWebCell.h"
@interface LoanWebCell()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation LoanWebCell
-(void)awakeFromNib{
    [super awakeFromNib];
    _webView.scrollView.bounces = NO;
}
-(void)setContent:(NSString *)content{
    _content = content;
    [_webView loadHTMLString:content baseURL:nil];
}

@end
