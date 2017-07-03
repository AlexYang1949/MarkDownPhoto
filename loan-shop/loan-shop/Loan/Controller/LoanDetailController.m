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

@interface LoanDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@end

@implementation LoanDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _titleArray = @[@"申请条件",@"申请材料",@"审核说明"];
    // 申请条件 申请材料 审核说明
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 180;
    }else{
        return 80;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        LoanDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanDetailHeaderCell"];
        return cell;
    }else{
        LoanQualifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanQualifyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = _titleArray[indexPath.row-1];
        return cell;
    }
}



@end
