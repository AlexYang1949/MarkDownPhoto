//
//  HistoryController.m
//  loan-shop
//
//  Created by yangzhaoheng on 2017/7/15.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "HistoryController.h"

@interface HistoryController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableFooterView = [[UIView alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}
- (IBAction)topClick:(UIButton *)sender{
    for (UIView *view in self.view.subviews) {
        if ([view isEqual:sender]) {
            [sender setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
        }else if([view isKindOfClass:[UIButton class]]){
            [(UIButton *)view setTitleColor:COLOR_GRAY forState:UIControlStateNormal];
        }
    }
    NSString *type;
    if (sender.tag == 0) {
        type = @"贷款";
    }else{
        type = @"信用卡";
    }
    [LoanApi getHistoryWithMobile:@"18810821007" type:type finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        NSArray *result = resultObj[@"result"];
        
    }];
}




@end
