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

@interface HomeViewController ()<KNBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *urlArr;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) KNBannerView *bannerView;
@property (weak, nonatomic) IBOutlet HotCollectionView *collectionView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBanner];
    [self loadCollectionView];
}

- (KNBannerView *)setupBanner{
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:self.urlArr
                                                                      frame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT_BANNER)];
    /*
     * 以下都是 基本属性的设置
     */
    [bannerView setDelegate:self]; // 设置代理, 为了实现代理方法
    
    KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
    
    [viewM setIsNeedPageControl:YES]; // 默认系统PageControl
    [viewM setPageControlStyle:KNBannerPageControlStyleMiddel]; // 设置pageControl 在居中
    
    [viewM setIsNeedTimerRun:YES]; // 是否需要定时
    [viewM setBannerTimeInterval:1]; // 改变 定时器时间
    
    [bannerView setBannerViewModel:viewM]; // 通过模型设置属性 -->赋值
    
    [self.collectionView addSubview:bannerView];
    _bannerView = bannerView;

    return _bannerView;
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
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        HotLoanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotLoanCell" forIndexPath:indexPath];
        return cell;
    }else{
        HotCreditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCreditCell" forIndexPath:indexPath];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HotHeaderCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HotHeaderCell" forIndexPath:indexPath];
    if (indexPath.section==0) {
        header.moreBlcok =^(){
            [self.tabBarController setSelectedIndex:1];
        };
    }else{
        header.moreBlcok =^(){
            [self.tabBarController setSelectedIndex:2];
        };
    }
    return  header;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
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
    [self openHtml:@"https://www.baidu.com"];
}


- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView collectionViewCell:(KNBannerCollectionViewCell *)collectionViewCell didSelectItemAtIndexPath:(NSInteger)index{
    
    NSLog(@"BannerView :%zd -- index :%zd",bannerView.tag,index);
}

- (NSMutableArray *)urlArr{
    if (!_urlArr) {
        _urlArr = [NSMutableArray array];
        NSString *url1 = @"http://ww1.sinaimg.cn/mw690/9bbc284bgw1f9rk86nq06j20fa0a4whs.jpg";
        NSString *url2 = @"http://ww3.sinaimg.cn/mw690/9bbc284bgw1f9qg0bazmnj21hc0u0dop.jpg";
        NSString *url3 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg0nw7zbj20rs0jntk7.jpg";
        NSString *url4 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg0utssrj20sg0hyx0o.jpg";
        NSString *url5 = @"http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg10w0w1j20s40jsah1.jpg";
        
        [_urlArr addObject:url1];
        [_urlArr addObject:url2];
        [_urlArr addObject:url3];
        [_urlArr addObject:url4];
        [_urlArr addObject:url5];
    }
    return _urlArr;
}

@end
