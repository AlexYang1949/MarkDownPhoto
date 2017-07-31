//
//  HistoryController.m
//  loan-shop
//
//  Created by yangzhaoheng on 2017/7/15.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "HistoryController.h"
#import "HistoryModel.h"

@interface HistoryController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;

@end

@implementation HistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self setupDataType:@"贷款"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupDataType:(NSString *)type{
    if (ISNULL([UserManager currentUser])) {
        [self showHudTitle:@"您还未登录！" delay:1];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getHistoryWithMobile:[UserManager currentUser] type:type finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        if (!success) {
            [self showHudTitle:@"请检查网络连接后重试！" delay:1];
            return ;
        }
        NSDictionary *result = resultObj[@"result"];
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if (!ISNULL(result)&&errorCode==200) {
            _dataArray = [HistoryModel mj_objectArrayWithKeyValuesArray:result[@"content"]];
            [_tableView reloadData];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryModel *model = _dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.iconShowUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    cell.textLabel.text = model.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
    [self setupDataType:type];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryModel *model = _dataArray[indexPath.row];
    
    [self openHtml:model.refLink];
}


@end
