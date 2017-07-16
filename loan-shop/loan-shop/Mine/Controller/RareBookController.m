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

@end

@implementation RareBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"秘籍";
    _tableView.tableFooterView = [UIView new];
    [self loadDataWithId:@"1"];
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
