//
//  LoanDetailHeaderCell.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/3.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoanDetailHeaderCell.h"

@interface LoanDetailHeaderCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UILabel *reteLabel;
@property (weak, nonatomic) IBOutlet UILabel *termLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *applyCountLabel;

@end

@implementation LoanDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LoanDetailModel *)model{
    _nameLabel.text = model.name;
    _remark.text = model.remark;
    _limitLabel.text = model.limitation;
    _reteLabel.text = model.rate;
    _termLabel.text = model.term;
    _applyCountLabel.text = [NSString stringWithFormat:@"%@人贷款成功",model.applyCount];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
}

@end
