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
        NSDictionary *result = resultObj[@"result"];
        if (!ISNULL(result)) {
            _dataArray = [HomeCardModel mj_objectArrayWithKeyValuesArray:result[@"content"]];
            [_tableView reloadData];
        }
        [hud hideAnimated:YES];
    }];
}

- (void)process{
    ProcessViewController *processVc = [self getViewController:@"ProcessViewController" onStoryBoard:@"CreditCard"];
    [self.navigationController pushViewController:processVc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCardModel *cardInfo = _dataArray[indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = cardInfo.name;
    cell.detailTextLabel.text = cardInfo.remark;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:cardInfo.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
