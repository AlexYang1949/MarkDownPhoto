//
//  RareBookController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/4.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "RareBookController.h"
#import "RareBookCell.h"
#import "RareModel.h"

@interface RareBookController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (nonatomic , strong) NSArray *buttonArray;
@end

@implementation RareBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"秘籍";
    _tableView.tableFooterView = [UIView new];
    _buttonArray = @[_button1,_button2,_button3,_button4];
    [self loadId];
    
}

- (void)loadId{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getRareIdFinish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        if (!success) {
            [self showHudTitle:@"网络错误！" delay:1];
            return ;
        }
        NSDictionary *result = resultObj[@"result"];
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if (!ISNULL(result)&&errorCode==200) {
            NSArray *buttonTitleArray = result[@"content"];
            [buttonTitleArray enumerateObjectsUsingBlock:^(NSDictionary *titleDict, NSUInteger idx, BOOL * _Nonnull stop) {
                if (_buttonArray.count<=idx) return;
                NSString *title = titleDict[@"title"];
                NSUInteger tag = [titleDict[@"id"] integerValue];
                ((UIButton *)_buttonArray[idx]).tag = tag;
                ((UIButton *)_buttonArray[idx]).titleLabel.text = title;
                ((UIButton *)_buttonArray[idx]).hidden = NO;
            }];
            [self loadDataWithId:@"1"];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }
    }];
}

- (void)loadDataWithId:(NSString *)tabId{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getRareListWithId:tabId finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        if (!success) {
            [self showHudTitle:@"网络错误！" delay:1];
            return ;
        }
        NSDictionary *result = resultObj[@"result"];
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if (!ISNULL(result)&&errorCode==200) {
            _dataArray = [RareModel mj_objectArrayWithKeyValuesArray:result[@"content"]];
            [_tableView reloadData];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }
    }];
}

- (IBAction)selectTop:(UIButton *)sender {
    
    for (UIView *view in self.view.subviews) {
        if ([view isEqual:sender]) {
            [sender setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
            [self loadDataWithId:[NSString stringWithFormat:@"%ld",sender.tag]];
        }else if([view isKindOfClass:[UIButton class]]){
            [(UIButton *)view setTitleColor:COLOR_GRAY forState:UIControlStateNormal];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RareBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RareBookCell"];
    cell.model = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RareModel *model = _dataArray[indexPath.row];
    [self openHtmlWithId:model.id];
}

@end
