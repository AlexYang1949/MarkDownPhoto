//
//  ProcessViewController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "ProcessViewController.h"
#import "HomeCardModel.h"


@interface ProcessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *bankList;
@end

@implementation ProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    // Do any additional setup after loading the view.
}

- (void)setupData{
    [LoanApi getBankListPageNum:0 Size:100 finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        NSDictionary *result = resultObj[@"result"];
        if (!ISNULL(result)) {
            _bankList = [HomeCardModel mj_objectArrayWithKeyValuesArray:(NSArray *)result[@"content"]];
            [_tableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _bankList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCardModel *cardInfo = _bankList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = cardInfo.name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:cardInfo.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCardModel *cardInfo = _bankList[indexPath.row];
    [self openHtml:cardInfo.link];
}



@end
