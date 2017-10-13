//
//  ViewController.m
//  Listen
//
//  Created by 杨照珩 on 2017/10/1.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "ViewController.h"
#import "CallListController.h"
#import "MapController.h"

//#define TEST

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *listArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Top";
#ifdef TEST
    self.listArray = @[@"位置",@"通话记录",@"测试"];
#else
    self.listArray = @[@"位置",@"通话记录"];
#endif
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.listArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self.navigationController pushViewController:[self getController:@"MapController"] animated:YES];
    }else if (indexPath.row==1){
        [self.navigationController pushViewController:[self getController:@"CallListController"] animated:YES];
    }else if (indexPath.row==2){
        [self.navigationController pushViewController:[self getController:@"TestController"] animated:YES];
    }
}

- (UIViewController *)getController:(NSString *)controller{
    return [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:controller];
}
@end
