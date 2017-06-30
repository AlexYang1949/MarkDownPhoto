//
//  HotHeaderCell.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "HotHeaderCell.h"
@interface HotHeaderCell()
@property(nonatomic, strong)UILabel *titleLable;
@end

@implementation HotHeaderCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.width, self.height)];
    _titleLable.text = @"标题";
    _titleLable.textColor = [UIColor darkGrayColor];
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_titleLable];
}
@end
