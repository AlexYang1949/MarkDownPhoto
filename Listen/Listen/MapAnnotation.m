//
//  MapAnnotation.m
//  Listen
//
//  Created by 杨照珩 on 2017/10/2.
//  Copyright © 2017年 loanshop. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
- (instancetype)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self != nil) {
        self.coordinate = coord;
    }
    return self;
}
@end
