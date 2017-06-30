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
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.height - HEIGHT_TITLE, self.width, HEIGHT_TITLE)];
    _titleLable.text = @"标题";
    _titleLable.textColor = [UIColor darkGrayColor];
    self.backgroundColor = COLORHEX(0xf6f6f6);
    [self addSubview:_titleLable];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLable.text = title;
}
@end
