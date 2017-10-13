//
//  CallListController.m
//  Listen
//
//  Created by 杨照珩 on 2017/10/1.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "CallListController.h"
#import <AFNetworking/AFNetworking.h>

@interface CallListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)NSArray *callArray;
@end

@implementation CallListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Call";
    [self setupData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.callArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *callDict = self.callArray[indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.textLabel.text = callDict[@"number"];
    NSString * timeStampString = [NSString stringWithFormat:@"%.f",[callDict[@"date"] doubleValue]];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.detailTextLabel.text = [objDateformat stringFromDate: date];
    
    return cell;
}

- (void)setupData{
    [[AFHTTPSessionManager manager] GET:@"http://116.196.68.197/call" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject&&responseObject[@"data"]&&[responseObject[@"code"] longValue] ==0) {
            NSString *listStr = responseObject[@"data"][@"list"];
            NSData* data = [listStr dataUsingEncoding:NSUTF8StringEncoding];
            NSError* error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if ([result isKindOfClass:[NSArray class]]) {
                if (result!=nil) {
                    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"date" ascending:NO];
                    NSMutableArray *sortDescriptors=[[NSMutableArray alloc] initWithObjects:&sorter count:1];
                    NSArray *sortArray=[result sortedArrayUsingDescriptors:sortDescriptors];
                    self.callArray = sortArray;
                    [self.tableView reloadData];
                }else{
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                                   message:@"没有新数据"
                                                                  delegate:self
                                                         cancelButtonTitle:@"好的"
                                                         otherButtonTitles:nil];
                    [alert show];
                }
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
                                                       message:@"数据错误"
                                                      delegate:self
                                             cancelButtonTitle:@"好的"
                                             otherButtonTitles:nil];
        [alert show];
    }];
}

@end
