//
//  MapController.m
//  Listen
//
//  Created by 杨照珩 on 2017/10/1.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "MapController.h"
#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"


@interface MapController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *lonLabel;
@property(nonatomic, strong) MapAnnotation *annotation;
@end

@implementation MapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Map";
    self.mapView.delegate = self;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView.showsUserLocation = YES;
    // Do any additional setup after loading the view.
}

- (void)locateWithLon:(CGFloat)lon lat:(CGFloat)lat{
    if (_annotation) {
        [self.mapView removeAnnotation:_annotation];
    }
    //创建CLLocation 设置经纬度
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
    CLLocationCoordinate2D coord = [loc coordinate];

    _annotation = [[MapAnnotation alloc] initWithLocation:coord];
//添加标注
    _annotation.title = @"当前位置";
    [self.mapView addAnnotation:_annotation];
    
//放大到标注的位置

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    if((region.center.latitude >= -90) && (region.center.latitude <= 90) && (region.center.longitude >= -180) && (region.center.longitude <= 180)){
        [self.mapView setRegion:region animated:YES];
    }else{
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"位置超出范围"
                                                      delegate:self
                                             cancelButtonTitle:@"好的"
                                             otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction)refresh:(id)sender {
    [[AFHTTPSessionManager manager] GET:@"http://116.196.68.197/location" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject&&responseObject[@"data"]) {
            NSString *jsonString = responseObject[@"data"];
            CGFloat lon;
            CGFloat lat;
            NSError *err;
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
            if (data[@"lon"]!=nil&&data[@"lat"]!=nil) {
                lon = [data[@"lon"] floatValue];
                lat = [data[@"lat"] floatValue];
                self.latLabel.text = [NSString stringWithFormat:@"纬度:%f",lat];
                self.lonLabel.text = [NSString stringWithFormat:@"经度:%f",lon];
                [self locateWithLon:lon lat:lat];
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

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // 创建MKAnnotationView
    static NSString *ID = @"tuangou";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        annoView.image = [UIImage imageNamed:@"loc"];
        annoView.canShowCallout = YES;
        annoView.selected = YES;
    }
    // 传递模型数据
    annoView.annotation = annotation;
    return annoView;
}

@end
