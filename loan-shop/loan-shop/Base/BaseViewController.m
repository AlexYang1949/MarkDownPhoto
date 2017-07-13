//
//  BaseViewController.m
//  贷款超市
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 dkcs. All rights reserved.
//

#import "BaseViewController.h"
#import "WebController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action
{
    self.navigationItem.rightBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg title:title action:action type:1];
}
- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action
{
    self.navigationItem.leftBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg title:title action:action type:0];
}

- (UIBarButtonItem *)getButtonItemWithImg:(NSString *)norImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action type:(int)leftOrRight
{
    CGSize navbarSize = self.navigationController.navigationBar.bounds.size;
    CGRect frame = CGRectMake(0, 0, navbarSize .height, navbarSize.height - 3);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    if (norImg)
        [button setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    if (selImg)
        [button setImage:[UIImage imageNamed:selImg] forState:UIControlStateHighlighted];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setTitleColor:[UIColor colorWithWhite:0.400 alpha:1.000] forState:UIControlStateNormal];
    }
    button.frame = frame;
    if (leftOrRight==0) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    }else{
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    }
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* tmpBarBtnItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    return tmpBarBtnItem;
}



-(id)getViewController:(NSString*)controllName onStoryBoard:(NSString*)boardName {
    return [[UIStoryboard storyboardWithName:boardName bundle:nil] instantiateViewControllerWithIdentifier:controllName];
}

-(void)openHtml:(NSString *)url{
    WebController *webVc = [[WebController alloc] init];
    webVc.urlStr = url;
    [self.navigationController pushViewController:webVc animated:YES];
}



@end
