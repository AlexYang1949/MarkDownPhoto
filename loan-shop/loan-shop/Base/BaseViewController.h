//
//  BaseViewController.h
//  贷款超市
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 dkcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(id)getViewController:(NSString*)controllName onStoryBoard:(NSString*)boardName;
-(void)openHtml:(NSString *)url;
@end