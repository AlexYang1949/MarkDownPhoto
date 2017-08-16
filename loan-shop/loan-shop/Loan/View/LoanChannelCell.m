//
//  LoanChannelCell.m
//  loan-shop
//
//  Created by Alex yang on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoanChannelCell.h"
@interface LoanChannelCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;


@end
@implementation LoanChannelCell
-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)setModel:(LoanDetailModel *)model{
    _model = model;
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    _nameLabel.text = model.name;
    _remark.text = model.remark;
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
