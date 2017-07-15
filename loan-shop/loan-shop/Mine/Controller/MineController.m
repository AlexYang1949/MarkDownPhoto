//
//  MineController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "MineController.h"
#import "LoginController.h"
#import "BaseNavController.h"
#import "RareBookController.h"
#import "ProcessViewController.h"
#import "HistoryController.h"

@interface MineController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.tableFooterView=[[UIView alloc]init];
    _dataArray = @[@[@"注册／登录"],@[@"浏览记录",@"信用卡进度查询"],@[@"交流群",@"秘籍",@"关于我们"],@[@"设置"]].mutableCopy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)_dataArray[section]).count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"icon"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 60;
    }else{
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==_dataArray.count-1) {
        return 0;
    }
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2 &&indexPath.row==1) {
        RareBookController *rareVc = [self getViewController:@"RareBookController" onStoryBoard:@"Mine"];
        [self.navigationController pushViewController:rareVc animated:YES];
    }
    if (indexPath.section==1 && indexPath.row==1) {
        ProcessViewController *processVc = [self getViewController:@"ProcessViewController" onStoryBoard:@"CreditCard"];
        [self.navigationController pushViewController:processVc animated:YES];
    }
    if (indexPath.section==0 && indexPath.row==0 &&[_dataArray[0][0] isEqualToString:@"注册／登录"]) {
        LoginController *loginVc = [self getViewController:@"LoginController" onStoryBoard:@"Mine"];
        BaseNavController *loginNav = [[BaseNavController alloc] initWithRootViewController:loginVc];
        loginVc.block = ^(NSString *mobile,NSString *token){
            _dataArray[0] = @[[NSString stringWithFormat:@"%@ 已登陆",mobile]];
            _dataArray[4] = @[@"退出登陆"];
            [_tableView reloadData];
        };
        [self presentViewController:loginNav animated:YES completion:nil];
    }
    if (indexPath.section==4) {
        _dataArray[0] = @"注册／登录";
        [_tableView reloadData];
    }
    
    if (indexPath.section==1&&indexPath.row==0) {
        HistoryController *loginVc = [self getViewController:@"HistoryController" onStoryBoard:@"Mine"];
        [self.navigationController pushViewController:loginVc animated:YES];

    }
}

@end
