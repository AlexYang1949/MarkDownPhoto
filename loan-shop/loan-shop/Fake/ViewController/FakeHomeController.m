//
//  FakeHomeController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/5.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "FakeHomeController.h"
#import "ProcessView.h"
#import "FakeInfoViewController.h"
#define Rate 4/365
@interface FakeHomeController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic , strong) NSArray *pickerArray;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *getLabel;
@property (nonatomic , strong) NSString *day;
@property (nonatomic , strong) NSString *money;
@end

@implementation FakeHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    ProcessView *pv =  [[[NSBundle mainBundle] loadNibNamed:@"FackHeader" owner:nil options:nil] lastObject];
    pv.frame = _topView.frame;
    pv.index = 0;
    [_topView addSubview:pv];
    
    _pickerArray = @[@[@"5000",@"2000",@"1000"],@[@"28",@"14",@"7"]];
    _day = _pickerArray[1][0];
    _money = _pickerArray[0][0];
    [self reloadData];
}

#pragma mark -- delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _pickerArray.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return ((NSArray *)_pickerArray[component]).count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerArray[component] objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        _money = _pickerArray[0][row];
    }else{
        _day = _pickerArray[1][row];
    }
    [self reloadData];
}

- (void)reloadData{
    _rateLabel.text = [NSString stringWithFormat:@"利息：%ld",[_day integerValue]*[_money integerValue]*Rate];
    _getLabel.text = [NSString stringWithFormat:@"实际到账：%ld",[_money integerValue]-[_day integerValue]*[_money integerValue]*Rate];
}

- (IBAction)nextStep:(UIButton *)sender {
    FakeInfoViewController *fakeVc = [self getViewController:@"FakeInfoViewController" onStoryBoard:@"Fake"];
    fakeVc.titleArray = @[@"姓名",@"身份证",@"住址",@"是否婚配"];
    fakeVc.index = 1;
    fakeVc.title = @"验证身份";
    [self.navigationController pushViewController:fakeVc animated:YES];
}


@end
