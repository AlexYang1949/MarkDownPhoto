//
//  LoanQualifyCell.h
//  loan-shop
//
//  Created by Alex yang on 2017/7/3.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanQualifyCell : UITableViewCell
@property(nonatomic ,strong)NSString *title;
@property (nonatomic , strong) NSString *content;
+(CGFloat)countHeightWithTitle:(NSString *)title;
@end
