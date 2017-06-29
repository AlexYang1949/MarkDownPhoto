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

-(id)getViewController:(NSString*)controllName onStoryBoard:(NSString*)boardName {
    return [[UIStoryboard storyboardWithName:boardName bundle:nil] instantiateViewControllerWithIdentifier:controllName];
}

-(void)openHtml:(NSString *)url{
    WebController *webVc = [[WebController alloc] init];
    webVc.urlStr = url;
    [self.navigationController pushViewController:webVc animated:YES];
}



@end
