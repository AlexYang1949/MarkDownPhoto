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
static NSString *cellId = @"loanChannelCell";
@interface LoanController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet LoanCollectionView *collectionView;

@end

@implementation LoanController
-(void)viewDidLoad{
    [self.collectionView setCollectionViewLayout:[self layout]];
//    [self.collectionView registerClass:[LoanChannelCell class] forCellWithReuseIdentifier:@"loanCell"];
}

- (UICollectionViewFlowLayout *)layout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MAIN_BOUNDS_WIDTH/2 ,80);
    layout.headerReferenceSize = CGSizeMake(MAIN_BOUNDS_WIDTH, 40);
    //行与行的最小间距
    layout.minimumLineSpacing = 0;
    //每行的item与item之间最小间隔
    layout.minimumInteritemSpacing = 0;
    return layout;
//    layout.sectionInset = UIEdgeInsetsMake(0, 0, 15, 0);
}

#pragma mark - collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LoanChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loanCell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self openHtml:@"https://www.baidu.com"];
}

// header footer
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    TTAppLayoutHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SUPPLEMENT_ID forIndexPath:indexPath];
//    header.titleName = @"应用";
//    return  header;
//}


@end
