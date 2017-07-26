//
//  ProcessViewController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "ProcessViewController.h"
#import "HomeCardModel.h"
#import "ProcessCell.h"


@interface ProcessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self setupData];

}

- (void)setupData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getBankListPageNum:0 Size:100 finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        if (!success) {
            [self showHudTitle:@"网络错误！" delay:1];
            return ;
        }
        NSDictionary *result = resultObj[@"result"];
        if (!ISNULL(result)) {
            _dataArray = [HomeCardModel mj_objectArrayWithKeyValuesArray:(NSArray *)result[@"content"]];
            [_tableView reloadData];
        }else{
            
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCardModel *cardInfo = _dataArray[indexPath.row];
    ProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = cardInfo;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCardModel *cardInfo = _dataArray[indexPath.row];
    [self openHtml:cardInfo.progress];
}



@end
