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

@end

@implementation CreditCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"进度查询" style:UIBarButtonItemStylePlain target:self action:@selector(process)];
}

- (void)process{
    ProcessViewController *processVc = [self getViewController:@"ProcessViewController" onStoryBoard:@"CreditCard"];
    [self.navigationController pushViewController:processVc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCardModel *cardInfo = [[HomeCardModel alloc] init];
    cardInfo.icon = @"icon";
    cardInfo.bankName = @"柠檬银行";
    cardInfo.subTitle = @"新用户办理即送100000万红包";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = cardInfo.bankName;
    cell.detailTextLabel.text = cardInfo.subTitle;
    cell.imageView.image = [UIImage imageNamed:cardInfo.icon];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self openHtml:@"https://www.baidu.com"];
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
