//
//  FakeInfoCell.m
//  loan-shop
//
//  Created by yangzhaoheng on 2017/7/8.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "FakeInfoCell.h"
@interface FakeInfoCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputView;
@end

@implementation FakeInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _inputView.delegate = self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setName:(NSString *)name{
    _nameLabel.text = name;
}

-(void)setContent:(NSString *)content{
    _inputView.text = content;
}

-(NSString *)content{
    return _inputView.text;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(myTextViewDidBeginEditing:)]) {
        return [self.delegate myTextViewDidBeginEditing:textField];
    }
    return YES;
}


@end
