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
@property(nonatomic, strong)UIButton *moreButton;

@end

@implementation HotHeaderCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

-(void)setHiddenMore:(BOOL)hiddenMore{
    _hiddenMore = hiddenMore;
    _moreButton.hidden = hiddenMore;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLable.text = title;
}

- (void)loadUI{
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.height-HEIGHT_TITLE, self.width/2, HEIGHT_TITLE)];
    [self.contentView addSubview:_titleLable];
    
    _moreButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width-100, self.height-HEIGHT_TITLE, 80, HEIGHT_TITLE)];
    [_moreButton setTitle:@"更多.." forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_moreButton setFont:[UIFont systemFontOfSize:15]];
    [_moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreButton];
    self.backgroundColor = COLORHEX(0xf6f6f6);
}

- (void)more{
    if (_moreBlcok) {
        _moreBlcok();
    }
}

@end
