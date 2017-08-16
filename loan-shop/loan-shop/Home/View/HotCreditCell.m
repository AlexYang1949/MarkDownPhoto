//
//  HotCreditCell.m
//  loan-shop
//
//  Created by Alex yang on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "HotCreditCell.h"
@interface HotCreditCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *applyLabel;

@end
@implementation HotCreditCell
-(void)setModel:(HomeCardModel *)model{
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    _nameLabel.text = model.name;
    _subTitleLabel.text = model.remark;
    _applyLabel.text = [NSString stringWithFormat:@"%@人正在申请",model.applyCount];
}
@end
