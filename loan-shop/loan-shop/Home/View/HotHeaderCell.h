//
//  HotHeaderCell.h
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/30.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotHeaderCell : UICollectionViewCell
@property(nonatomic ,strong) NSString *title;
@property(nonatomic, copy) void(^moreBlcok)();
@property(nonatomic) BOOL hiddenMore;

@end
