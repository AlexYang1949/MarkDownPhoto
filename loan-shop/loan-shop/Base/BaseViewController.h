//
//  BaseViewController.h
//  贷款超市
//
//  Created by Alex yang on 2017/6/29.
//  Copyright © 2017年 dkcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(id)getViewController:(NSString*)controllName onStoryBoard:(NSString*)boardName;
-(void)openHtml:(NSString *)url;
-(void)openHtmlWithId:(NSString *)rareId;
-(void)openHtmlWithContent:(NSString *)content;
- (void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action;
- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action;
- (void)showHudTitle:(NSString *)title delay:(CGFloat)delay;
- (BOOL)isLogin;

@end
