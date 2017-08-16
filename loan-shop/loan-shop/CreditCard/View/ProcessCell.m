//
//  ProcessCell.m
//  loan-shop
//
//  Created by Alex yang on 2017/7/26.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "ProcessCell.h"
@interface ProcessCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation ProcessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(HomeCardModel *)model{
    self.titleLabel.text = model.name;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
}

@end
