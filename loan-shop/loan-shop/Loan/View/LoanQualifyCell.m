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

//+(CGFloat)countHeightWithTitle:(NSString *)title{
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]};
//    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width-3*SidePadding-TitleImageH, MAXFLOAT);
//    CGFloat textHeight =  [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
//    return NormalHeight + textHeight;
//}

@end
