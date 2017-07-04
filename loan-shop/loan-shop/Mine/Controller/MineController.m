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

@interface MineController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSArray *dataArray;
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.tableFooterView=[[UIView alloc]init];
    _dataArray = @[@[@"浏览记录",@"信用卡进度查询"],@[@"交流群",@"秘籍",@"关于我们"],@[@"设置",@"注册登录"]];
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==_dataArray.count-1) {
        return 0;
    }
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1 &&indexPath.row==1) {
        RareBookController *rareVc = [self getViewController:@"RareBookController" onStoryBoard:@"Mine"];
//        BaseNavController *rareNav = [[BaseNavController alloc] initWithRootViewController:rareVc];
        [self.navigationController pushViewController:rareVc animated:YES];
    }
    if (indexPath.section==_dataArray.count-1 && indexPath.row==1) {
        LoginController *loginVc = [self getViewController:@"LoginController" onStoryBoard:@"Mine"];
        BaseNavController *loginNav = [[BaseNavController alloc] initWithRootViewController:loginVc];
        [self presentViewController:loginNav animated:YES completion:nil];
    }
}

@end
