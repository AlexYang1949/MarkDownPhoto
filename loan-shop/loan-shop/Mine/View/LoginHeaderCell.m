//
//  LoginHeaderCell.m
//  loan-shop
//
//  Created by yangzhaoheng on 2017/8/13.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoginHeaderCell.h"
@interface LoginHeaderCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation LoginHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setName:(NSString *)name{
    _nameLabel.text = name;
}
@end
