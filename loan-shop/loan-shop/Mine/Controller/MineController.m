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
#import "UserManager.h"
#import "LoginHeaderCell.h"

@interface MineController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.tableFooterView=[[UIView alloc]init];
    _dataArray = @[@[@"注册／登录"],@[@"浏览记录",@"信用卡进度查询"],@[@"交流群",@"秘籍",@"关于我们"]].mutableCopy;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UserManager currentUser]) {
        _dataArray[0] = @[[NSString stringWithFormat:@"%@",[UserManager currentUser]]];
        _dataArray[3] = @[@"退出登录"];
        [_tableView reloadData];
    }

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
    if (indexPath.row==0&&indexPath.section==0) {
        LoginHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoginHeaderCell"];
        cell.name = _dataArray[indexPath.section][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 120;
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
    // 进度查询
    if (indexPath.section==1 && indexPath.row==1) {
        if(![self isLogin]) return;
        
        ProcessViewController *processVc = [self getViewController:@"ProcessViewController" onStoryBoard:@"CreditCard"];
        [self.navigationController pushViewController:processVc animated:YES];
    }
    if (indexPath.section==0 && indexPath.row==0 &&[_dataArray[0][0] isEqualToString:@"注册／登录"]) {
        LoginController *loginVc = [self getViewController:@"LoginController" onStoryBoard:@"Mine"];
        BaseNavController *loginNav = [[BaseNavController alloc] initWithRootViewController:loginVc];
        loginVc.block = ^(NSString *mobile,NSString *token){
            [UserManager saveUser:mobile];
            _dataArray[0] = @[[NSString stringWithFormat:@"%@",mobile]];
            _dataArray[3] = @[@"退出登录"];
            [_tableView reloadData];
        };
        [self presentViewController:loginNav animated:YES completion:nil];
    }
    // 退出登录
    if (indexPath.section==3) {
        _dataArray[0] = @[@"注册／登录"];
        [UserManager saveUser:nil];
        [self showHudTitle:@"您已退出登录" delay:0.5];
        [_dataArray removeObjectAtIndex:3];
        [_tableView reloadData];
    }
    // 浏览历史
    if (indexPath.section==1&&indexPath.row==0) {
        HistoryController *loginVc = [self getViewController:@"HistoryController" onStoryBoard:@"Mine"];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
    
    // 交流群
    if (indexPath.section==2&&indexPath.row==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [LoanApi getGroupDetailFinish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
            [hud hideAnimated:YES];
            if (!success) {
                [self showHudTitle:@"请检查网络连接后重试！" delay:1];
                return ;
            }
            NSDictionary *result = resultObj[@"result"];
            NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
            if (!ISNULL(result)&&errorCode==200) {
                NSString *content = result[@"content"];
                [self openHtmlWithContent:content];
            }else{
                [self showHudTitle:resultObj[@"errorMessage"] delay:1];
            }

        }];
    }
    
    // 关于我们
    if (indexPath.section==2&&indexPath.row==2) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [LoanApi getAbortUsDetailFinish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
            [hud hideAnimated:YES];
            if (!success) {
                [self showHudTitle:@"请检查网络连接后重试！" delay:1];
                return ;
            }
            NSDictionary *result = resultObj[@"result"];
            NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
            if (!ISNULL(result)&&errorCode==200) {
                NSString *content = result[@"content"];
                [self openHtmlWithContent:content];
            }else{
                [self showHudTitle:resultObj[@"errorMessage"] delay:1];
            }
            
        }];
    }
}

@end
