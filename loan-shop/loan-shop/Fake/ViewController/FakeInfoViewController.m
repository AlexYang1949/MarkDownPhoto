//
//  FakeInfoViewController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/5.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "FakeInfoViewController.h"
#import "FakeInfoCell.h"
#import "ProcessView.h"
#import "FakeResultController.h"

@interface FakeInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation FakeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ProcessView *pv =  [[[NSBundle mainBundle] loadNibNamed:@"FackHeader" owner:nil options:nil] lastObject];
    pv.frame = _topView.frame;
    pv.index = _index;
    [_topView addSubview:pv];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FakeInfoCell *fakeCell = [tableView dequeueReusableCellWithIdentifier:@"FakeInfoCell"];
    fakeCell.name = _titleArray[indexPath.row];
    return fakeCell;
}

- (IBAction)nextPage:(UIButton *)sender {
    if (_index==3) {
        FakeResultController *resultVc = [self getViewController:@"FakeResultController" onStoryBoard:@"Fake"];
        [self.navigationController pushViewController:resultVc animated:YES];
    }else{
        FakeInfoViewController *fakeVc = [self getViewController:@"FakeInfoViewController" onStoryBoard:@"Fake"];
        fakeVc.index = _index+1;
        if (_index==1) {
            fakeVc.titleArray = @[@"运营商信息"];
        }else if (_index==2){
            fakeVc.titleArray = @[@"父亲姓名",@"父亲手机号",@"母亲姓名",@"母亲手机号"];
        }
        [self.navigationController pushViewController:fakeVc animated:YES];
    }
}


@end
