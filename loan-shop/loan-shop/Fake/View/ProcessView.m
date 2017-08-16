//
//  ProcessView.m
//  loan-shop
//
//  Created by Alex yang on 2017/7/5.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "ProcessView.h"
@interface ProcessView()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moneyView;
@property (weak, nonatomic) IBOutlet UIImageView *idView;
@property (weak, nonatomic) IBOutlet UIImageView *phoneView;
@property (weak, nonatomic) IBOutlet UIImageView *parentView;

@end
@implementation ProcessView

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)setIndex:(NSUInteger)index{
    _moneyLabel.textColor = COLOR_GRAY;
    _idLabel.textColor = COLOR_GRAY;
    _phoneLabel.textColor = COLOR_GRAY;
    _loanLabel.textColor = COLOR_GRAY;
    NSString *chooseM = @"chooseM_no";
    NSString *identity = @"identity_no";
    NSString *parent = @"parent_no";
    NSString *phone = @"phone_no";
    switch (index) {
        case 0:
            _moneyLabel.textColor = COLOR_MAIN;
            chooseM = @"chooseM";
            break;
        case 1:
            _idLabel.textColor = COLOR_MAIN;
            identity = @"identity";
            break;
        case 2:
            _phoneLabel.textColor = COLOR_MAIN;
            phone = @"phone";
            
            break;
        case 3:
            _loanLabel.textColor = COLOR_MAIN;
            parent = @"parent";
            break;
        default:
            break;
    }
    [_moneyView setImage:[UIImage imageNamed:chooseM]];
    [_idView setImage:[UIImage imageNamed:identity]];
    [_phoneView setImage:[UIImage imageNamed:phone]];
    [_parentView setImage:[UIImage imageNamed:parent]];
}

@end
