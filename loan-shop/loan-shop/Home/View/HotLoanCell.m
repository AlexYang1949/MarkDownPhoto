//
//  HotLoanCell.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "HotLoanCell.h"
@interface HotLoanCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *termLable;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;

@end

@implementation HotLoanCell
-(void)setModel:(LoanDetailModel *)model{
    _model = model;
    _nameLabel.text = model.name;
    _termLable.text = model.term;
    _limitLabel.text = model.limitation;
}
@end
