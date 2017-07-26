//
//  CreditCardController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "CreditCardController.h"
#import "ProcessViewController.h"
#import "HomeCardModel.h"
#import "CreditCardCell.h"
#import "LoginController.h"
#import "BaseNavController.h"
@interface CreditCardController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;

@end

@implementation CreditCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"进度查询" style:UIBarButtonItemStylePlain target:self action:@selector(process)];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self setupData];
}
- (void)setupData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getBankListPageNum:0 Size:10000 finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        if (!success) {
            [self showHudTitle:@"网络错误！" delay:1];
            return ;
        }
        NSDictionary *result = resultObj[@"result"];
        if (!ISNULL(result)) {
            _dataArray = [HomeCardModel mj_objectArrayWithKeyValuesArray:result[@"content"]];
            [_tableView reloadData];
        }
        
    }];
}

- (void)process{
    if(![self isLogin]) return;
    ProcessViewController *processVc = [self getViewController:@"ProcessViewController" onStoryBoard:@"CreditCard"];
    [self.navigationController pushViewController:processVc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCardModel *cardInfo = _dataArray[indexPath.row];
    CreditCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditCardCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = cardInfo;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(![self isLogin]) return;
    [self openHtml:((HomeCardModel *)_dataArray[indexPath.row]).link];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_BOUNDS_WIDTH, 30)];
    label.text = @"   信用卡推荐";
    label.textColor = [UIColor blackColor];
    label.backgroundColor = COLOR_BACK;
    return label;
}
@end
