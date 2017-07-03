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
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        LoanDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanDetailHeaderCell"];
        return cell;
    }else{
        LoanQualifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanQualifyCell"];
        return cell;
    }
}



@end
