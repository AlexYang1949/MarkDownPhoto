//
//  HomeViewController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "HomeViewController.h"
#import "KNBannerView.h"
#import "HotCollectionView.h"
#import "HotLoanCell.h"
#import "HotCreditCell.h"
#import "HotHeaderCell.h"
#import "LoanDetailController.h"
#import "BaseNavController.h"
#import "LoginController.h"
// model
#import "HomeCardModel.h"
#import "AdModel.h"
@interface HomeViewController ()<KNBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *urlArr;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) KNBannerView *bannerView;
@property (weak, nonatomic) IBOutlet HotCollectionView *collectionView;

@property (nonatomic, strong) NSArray *bankArray;
@property (nonatomic, strong) NSArray *loanArray;
@property (nonatomic , strong) NSArray *adArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadCollectionView];
    [self setupData];
}

- (void)setupData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LoanApi getAdImagePageNum:0 Size:1000 finish:^(BOOL success, NSDictionary * resultObj, NSError *error) {
        [hud hideAnimated:YES];
        if (!success) {
            [self showHudTitle:@"请检查网络连接后重试！" delay:1];
            return ;
        }
        NSDictionary *result = resultObj[@"result"];
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if (!ISNULL(result)&&success&&errorCode==200) {
            _adArray = [AdModel mj_objectArrayWithKeyValuesArray:result[@"content"]];
            [_adArray enumerateObjectsUsingBlock:^(AdModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.urlArr addObject:obj.showAdUrl];
            }];
            [self setupBanner];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }
        
    }];
    [LoanApi getHotPageNum:0 Size:1000 finish:^(BOOL success, NSDictionary *resultObj, NSError *error) {
        [hud hideAnimated:YES];
        NSDictionary *result = resultObj[@"result"];
        NSUInteger errorCode = [resultObj[@"errorCode"] integerValue];
        if (!ISNULL(result)&&errorCode==200) {
            _bankArray = [HomeCardModel mj_objectArrayWithKeyValuesArray:(NSArray *)result[@"banks"]];
            _loanArray = [LoanDetailModel mj_objectArrayWithKeyValuesArray:(NSArray *)result[@"loans"]];
            [_collectionView reloadData];
        }else{
            [self showHudTitle:resultObj[@"errorMessage"] delay:1];
        }
    }];
}

- (KNBannerView *)setupBanner{
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:self.urlArr
                                                                      frame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT_BANNER)];
    [bannerView setDelegate:self]; // 设置代理, 为了实现代理方法
    KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
    [viewM setIsNeedPageControl:NO]; // 默认系统PageControl
    [viewM setPageControlStyle:KNBannerPageControlStyleMiddel]; // 设置pageControl 在居中
    [viewM setIsNeedTimerRun:YES]; // 是否需要定时
    [viewM setBannerTimeInterval:3]; // 改变 定时器时间
    [bannerView setBannerViewModel:viewM]; // 通过模型设置属性 -->赋值
    [self.collectionView addSubview:bannerView];
    _bannerView = bannerView;
    return _bannerView;
}
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView collectionViewCell:(KNBannerCollectionViewCell *)collectionViewCell didSelectItemAtIndexPath:(NSInteger)index{
    [self openHtml:((AdModel *)_adArray[index]).link];
    NSLog(@"BannerView :%zd -- index :%zd",bannerView.tag,index);
}

- (void)loadCollectionView{
    [self.collectionView setCollectionViewLayout:[self layout]];
    [self.collectionView registerClass:[HotHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HotHeaderCell"];
}

- (UICollectionViewFlowLayout *)layout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(MAIN_BOUNDS_WIDTH, 30);
    //行与行的最小间距
    layout.minimumLineSpacing = 0;
    //每行的item与item之间最小间隔
    layout.minimumInteritemSpacing = 0;
    return layout;
}

#pragma mark - collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return _loanArray.count;
    }else{
        return _bankArray.count;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        HotLoanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotLoanCell" forIndexPath:indexPath];
        cell.model = _loanArray[indexPath.row];
        return cell;
    }else{
        HotCreditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCreditCell" forIndexPath:indexPath];
        cell.model = _bankArray[indexPath.row];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    HotHeaderCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HotHeaderCell" forIndexPath:indexPath];
    header.hiddenMore =YES;
    if (indexPath.section==0) {
        header.title = @"热门推荐";
        header.position = HEIGHT_BANNER;
        header.hiddenMore = NO;
        header.moreBlcok =^(){
            [self.tabBarController setSelectedIndex:1];
        };
    }else{
        header.title = @"推荐办卡";
        header.position = 0;
        header.hiddenMore = NO;
        header.moreBlcok =^(){
            [self.tabBarController setSelectedIndex:2];
        };
    }
    return  header;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (_bankArray.count==0&&_loanArray.count==0) {
        return CGSizeZero;
    }
    if (section==0) {
        return CGSizeMake(MAIN_BOUNDS_WIDTH, HEIGHT_BANNER+HEIGHT_TITLE);
    }else{
        return CGSizeMake(MAIN_BOUNDS_WIDTH, HEIGHT_TITLE);

    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(MAIN_BOUNDS_WIDTH/2 ,HEIGHT_CELL);
    }else{
        return CGSizeMake(MAIN_BOUNDS_WIDTH ,HEIGHT_CELL);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *urlStr = @"";
    if (indexPath.section==0) {
        LoanDetailController *detailVc = [self getViewController:@"LoanDetailController" onStoryBoard:@"Loan"];
        detailVc.loanId = ((LoanDetailModel *)_loanArray[indexPath.row]).id;
        detailVc.link = ((LoanDetailModel *)_loanArray[indexPath.row]).link;
        [self.navigationController pushViewController:detailVc animated:YES];
    }else{
        if(![self isLogin]) return;
        [LoanApi getBankDetailId:((HomeCardModel *)_bankArray[indexPath.row]).id finish:nil];
        urlStr = ((HomeCardModel *)_bankArray[indexPath.row]).link;
        [self openHtml:urlStr];
    }
    
}

- (NSMutableArray *)urlArr{
    if (!_urlArr) {
        _urlArr = [NSMutableArray array];
    }
    return _urlArr;
}

@end
