//
//  FakeInfoCell.m
//  loan-shop
//
//  Created by yangzhaoheng on 2017/7/8.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "FakeInfoCell.h"
@interface FakeInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputView;
@end

@implementation FakeInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setName:(NSString *)name{
    _nameLabel.text = name;
}

@end
