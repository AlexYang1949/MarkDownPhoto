//
//  RareBookController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/7/4.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "RareBookController.h"
#import "RareBookCell.h"

@interface RareBookController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RareBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"秘籍";
    _tableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    
}

- (IBAction)selectTop:(UIButton *)sender {
    for (UIView *view in self.view.subviews) {
        if ([view isEqual:sender]) {
            [sender setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
        }else if([view isKindOfClass:[UIButton class]]){
            [sender setTitleColor:COLORHEX(0xB8B8B8) forState:UIControlStateNormal];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RareBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RareBookCell"];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

@end
