//
//  MapAnnotation.h
//  Listen
//
//  Created by 杨照珩 on 2017/10/2.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation>
@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic ,copy)NSString *title;

- (instancetype)initWithLocation:(CLLocationCoordinate2D)coord;
@end
