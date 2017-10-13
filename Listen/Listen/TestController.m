//
//  TestController.m
//  Listen
//
//  Created by 杨照珩 on 2017/10/13.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "TestController.h"
#import <AFNetworking/AFNetworking.h>

@interface TestController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSDictionary *data;
@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    [[AFHTTPSessionManager manager] GET:@"http://116.196.68.197/location" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject&&responseObject[@"data"]) {
            NSString *jsonString = responseObject[@"data"];
            CGFloat lon;
            CGFloat lat;
            NSError *err;
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
            if (data[@"lon"]!=nil&&data[@"lat"]!=nil) {
                _data = data;
                [_tableView reloadData];
            }else{
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                               message:@"数据错误"
                                                              delegate:self
                                                     cancelButtonTitle:@"好的"
                                                     otherButtonTitles:nil];
                [alert show];
            }
        }else{
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                           message:@"数据错误"
                                                          delegate:self
                                                 cancelButtonTitle:@"好的"
                                                 otherButtonTitles:nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"网络错误"
                                                      delegate:self
                                             cancelButtonTitle:@"好的"
                                             otherButtonTitles:nil];
        [alert show];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.row==0) {
        NSString * timeStampString = [NSString stringWithFormat:@"%.f",[_data[@"time"] doubleValue]];
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *time = [objDateformat stringFromDate: date];
        cell.textLabel.text = time;
    }
    if (indexPath.row==1) {
        cell.textLabel.text = _data[@"desc"];
    }
    if (indexPath.row==2) {
        cell.textLabel.text = @"刷新";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        [self loadData];
    }
}
@end
