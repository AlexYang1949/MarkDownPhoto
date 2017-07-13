//
//  ProcessView.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/5.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "ProcessView.h"
@interface ProcessView()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanLabel;

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
    switch (index) {
        case 0:
            _moneyLabel.textColor = COLOR_MAIN;
            break;
        case 1:
            _idLabel.textColor = COLOR_MAIN;
            break;
        case 2:
            _phoneLabel.textColor = COLOR_MAIN;
            break;
        case 3:
            _loanLabel.textColor = COLOR_MAIN;
            break;
        default:
            break;
    }
}

@end
