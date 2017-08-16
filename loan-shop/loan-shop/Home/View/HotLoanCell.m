//
//  HotLoanCell.m
//  loan-shop
//
//  Created by Alex yang on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "HotLoanCell.h"
@interface HotLoanCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *termLable;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation HotLoanCell
-(void)setModel:(LoanDetailModel *)model{
    _model = model;
    _nameLabel.text = model.name;
    _termLable.text = [NSString stringWithFormat:@"期限：%@",model.term];
    _limitLabel.text = [NSString stringWithFormat:@"最高%@",model.limitation];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    if (model.yn) {
        _tipLabel.hidden = NO;
        _tipLabel.text = @"hot";
        _tipLabel.backgroundColor = [UIColor redColor];
    }
    if (model.nw) {
        _tipLabel.hidden = NO;
        _tipLabel.text = @"new";
        _tipLabel.backgroundColor = COLOR_MAIN;
    }
}
@end
