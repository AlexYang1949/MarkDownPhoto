//
//  HomeViewController.m
//  loan-shop
//
//  Created by 杨照珩 on 2017/6/29.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "HomeViewController.h"
#import "KNBannerView.h"

@interface HomeViewController ()<KNBannerViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *urlArr;
@property (nonatomic,weak  ) KNBannerView *bannerView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBanner];
}

// 样式1
- (void)setupBanner{
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:self.urlArr
                                                                      frame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    /*
     * 以下都是 基本属性的设置
     */
    [bannerView setDelegate:self]; // 设置代理, 为了实现代理方法

    
    KNBannerViewModel *viewM = [[KNBannerViewModel alloc] init]; // 统一通过 设置 模型来设置 里面的参数
    [bannerView setBannerViewModel:viewM]; // 通过模型设置属性 -->赋值

    [self.view addSubview:bannerView];
    _bannerView = bannerView;
}

- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView collectionViewCell:(KNBannerCollectionViewCell *)collectionViewCell didSelectItemAtIndexPath:(NSInteger)index{
    
    NSLog(@"%@",collectionViewCell.imageView);
    
    
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
