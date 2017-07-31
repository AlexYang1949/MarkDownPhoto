//
//  LoanController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "LoanController.h"
#import "LoanChannelCell.h"
#import "LoanCollectionView.h"
#import "LoanDetailController.h"
#import "HotHeaderCell.h"
#import "LoanDetailModel.h"
static NSString *cellId = @"loanCell";
@interface LoanController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet LoanCollectionView *collectionView;
@property(nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) NSMutableArray *titleArray;

@end

@implementation LoanController
-(void)viewDidLoad{
    [self.collectionView setCollectionViewLayout:[self layout]];
    [self.collectionView registerClass:[HotHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HotHeaderCell"];
    [self setupData];
}

- (void)setupData{
    _dataArray = @[].mutableCopy;
    _titleArray = @[].mutableCopy;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getLoanClassifyListPageNum:0 Size:10000 finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        if (!success) {
            [self showHudTitle:@"请检查网络连接后重试！" delay:1];
            return ;
        }
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        NSDictionary *result = resultObj[@"result"];
        if (!ISNULL(result)&&errorCode==200) {
            for (NSDictionary *dict in result) {
                NSArray *itemArray = [LoanDetailModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
                [_dataArray addObject:itemArray];
                [_titleArray addObject:dict[@"title"]];
            }
            [_collectionView reloadData];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }

    }];
}

- (UICollectionViewFlowLayout *)layout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MAIN_BOUNDS_WIDTH/2 ,HEIGHT_CELL);
    layout.headerReferenceSize = CGSizeMake(MAIN_BOUNDS_WIDTH, HEIGHT_TITLE);
    //行与行的最小间距
    layout.minimumLineSpacing = 0;
    //每行的item与item之间最小间隔
    layout.minimumInteritemSpacing = 0;
    return layout;
}

#pragma mark - collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *itemArray = _dataArray[section];
    return itemArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LoanChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.section][indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LoanDetailController *detailVc = [self getViewController:@"LoanDetailController" onStoryBoard:@"Loan"];
    detailVc.loanId = ((LoanDetailModel *)_dataArray[indexPath.section][indexPath.row]).id;
    detailVc.link = ((LoanDetailModel *)_dataArray[indexPath.row][indexPath.row]).link;
    [self.navigationController pushViewController:detailVc animated:YES];
}

// header footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HotHeaderCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HotHeaderCell" forIndexPath:indexPath];
    header.hiddenMore = YES;
    header.title = _titleArray[indexPath.section];
    return header;
}


@end
