//
//  LoanQualifyCell.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/3.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoanQualifyCell.h"
@interface LoanQualifyCell()
@property (weak, nonatomic) IBOutlet UILabel *condition;
@property (weak, nonatomic) IBOutlet UILabel *titleName;

@end

@implementation LoanQualifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _condition.text = @"年龄满18岁，年龄满18岁，年龄满18岁，年龄满18岁，年龄满18岁，年龄满18岁";
    // Initialization code
}

-(void)setTitle:(NSString *)title{
    self.titleName.text = title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
