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
@property(nonatomic ,strong) NSArray *dataArray;
@end

@implementation LoanController
-(void)viewDidLoad{
    [self.collectionView setCollectionViewLayout:[self layout]];
    [self.collectionView registerClass:[HotHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HotHeaderCell"];
    [self setupData];
}

- (void)setupData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getLoanListPageNum:0 Size:10000 finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        NSDictionary *result = resultObj[@"result"];
        if (!ISNULL(result)) {
            _dataArray = [LoanDetailModel mj_objectArrayWithKeyValuesArray:result[@"content"]];
            [_collectionView reloadData];
        }
        [hud hideAnimated:YES];
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
    return _dataArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LoanChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LoanDetailController *detailVc = [self getViewController:@"LoanDetailController" onStoryBoard:@"Loan"];
    detailVc.loanId = ((LoanDetailModel *)_dataArray[indexPath.row]).id;
    detailVc.link = ((LoanDetailModel *)_dataArray[indexPath.row]).link;
    [self.navigationController pushViewController:detailVc animated:YES];
}

// header footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HotHeaderCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HotHeaderCell" forIndexPath:indexPath];
    header.hiddenMore = YES;
    header.title = @"贷款推荐";
    return  header;
}


@end
