//
//  RareBookCell.m
//  loan-shop
//
//  Created by Alex yang on 2017/7/7.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "RareBookCell.h"
@interface RareBookCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation RareBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(RareModel *)model{
    _titleLabel.text = model.title;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
}
@end
