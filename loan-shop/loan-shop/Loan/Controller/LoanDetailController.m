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

@end

@implementation LoanDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        return cell;
    }
}



@end
