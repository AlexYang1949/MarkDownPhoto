//
//  BaseViewController.m
//  贷款超市
//
//  Created by Alex yang on 2017/6/29.
//  Copyright © 2017年 dkcs. All rights reserved.
//

#import "BaseViewController.h"
#import "WebController.h"
#import "LoginController.h"
#import "BaseNavController.h"

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
    WebController *webVc = [self getViewController:@"WebController" onStoryBoard:@"Base"];
    webVc.urlStr = url;
    [self.navigationController pushViewController:webVc animated:YES];
}

-(void)openHtmlWithId:(NSString *)rareId{
    WebController *webVc = [self getViewController:@"WebController" onStoryBoard:@"Base"];
    webVc.rareId = rareId;
    [self.navigationController pushViewController:webVc animated:YES];
}

-(void)openHtmlWithContent:(NSString *)content{
    WebController *webVc = [self getViewController:@"WebController" onStoryBoard:@"Base"];
    webVc.content = content;
    [self.navigationController pushViewController:webVc animated:YES];
}

- (void)showHudTitle:(NSString *)title delay:(CGFloat)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;

    hud.label.text = title;
    
    [hud hideAnimated:YES afterDelay:delay];
}

-(BOOL)isLogin{
    if (![UserManager currentUser]) {
        LoginController *loginVc = [self getViewController:@"LoginController" onStoryBoard:@"Mine"];
        BaseNavController *loginNav = [[BaseNavController alloc] initWithRootViewController:loginVc];
        loginVc.block = ^(NSString *mobile,NSString *token){
            [UserManager saveUser:mobile];
        };
        [self presentViewController:loginNav animated:YES completion:nil];
        return NO;
    }
    return YES;
}


@end
