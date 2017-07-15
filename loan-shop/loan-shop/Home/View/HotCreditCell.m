//
//  HotCreditCell.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "HotCreditCell.h"
@interface HotCreditCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
@implementation HotCreditCell
-(void)setModel:(HomeCardModel *)model{
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    _nameLabel.text = model.name;
    _subTitleLabel.text = model.remark;
}
@end
