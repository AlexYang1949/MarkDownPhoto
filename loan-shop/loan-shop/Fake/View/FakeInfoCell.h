//
//  FakeInfoCell.h
//  loan-shop
//
//  Created by yangzhaoheng on 2017/7/8.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTextDelegate <NSObject>

- (BOOL)myTextViewDidBeginEditing:(UITextField *)textView;

@end

@interface FakeInfoCell : UITableViewCell
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , assign) id<MyTextDelegate> delegate;
@end
