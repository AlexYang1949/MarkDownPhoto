//
//  LoanDetailController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/3.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoanDetailController.h"
#import "LoanDetailHeaderCell.h"
#import "LoanQualifyCell.h"
#import "LoginController.h"
#import "BaseNavController.h"

@interface LoanDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong) LoanDetailModel *model;
@property (nonatomic , strong) NSArray *titleArray;

@end

@implementation LoanDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _titleArray = @[@"申请条件",@"申请材料",@"审核说明"];
    // 申请条件 申请材料 审核说明
    [self setupData];
}

- (void)setupData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getLoanDetailId:_loanId finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        if (!success) {
            [self showHudTitle:@"网络错误！" delay:1];
            return ;
        }
        NSDictionary *result = resultObj[@"result"];
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if (!ISNULL(result)&&errorCode==200) {
            _model = [LoanDetailModel mj_objectWithKeyValues:result];
            [_tableView reloadData];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 180;
    }else if (indexPath.row==1) {
        return [LoanQualifyCell countHeightWithTitle:_model.requirement];
    }else if (indexPath.row==2){
        return [LoanQualifyCell countHeightWithTitle:_model.material];
    }else if (indexPath.row==3){
        return [LoanQualifyCell countHeightWithTitle:_model.instructions];
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        LoanDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanDetailHeaderCell"];
        cell.model = _model;
        return cell;
    }else{
        LoanQualifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanQualifyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = _titleArray[indexPath.row-1];
        if (indexPath.row==1) {
            cell.content = _model.requirement;
        }else if (indexPath.row==2){
            cell.content = _model.material;
        }else if (indexPath.row==3){
            cell.content = _model.instructions;
        }
        return cell;
    }
}

- (IBAction)applyNow:(id)sender {
    if (![UserManager currentUser]) {
        LoginController *loginVc = [self getViewController:@"LoginController" onStoryBoard:@"Mine"];
        BaseNavController *loginNav = [[BaseNavController alloc] initWithRootViewController:loginVc];
        loginVc.block = ^(NSString *mobile,NSString *token){
            [UserManager saveUser:mobile];
        };
        [self presentViewController:loginNav animated:YES completion:nil];
        return;
    }
    
    [self openHtml:_link];
}



@end
