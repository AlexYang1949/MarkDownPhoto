//
//  CreditCardCell.m
//  loan-shop
//
//  Created by yangzhaoheng on 2017/7/22.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "CreditCardCell.h"
@interface CreditCardCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyNumLabel;

@end
@implementation CreditCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(HomeCardModel *)model{
    self.nameLabel.text = model.name;
    self.subTitleLabel.text = model.remark;
    self.applyNumLabel.text = [NSString stringWithFormat:@"%@人正在申请",model.applyCount];

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
}

@end
