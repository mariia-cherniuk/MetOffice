//
//  WTCityAnnotation.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTCityAnnotation.h"
#import "WTCity.h"
#import "WTLocation.h"

@implementation WTCityAnnotation

- (instancetype)initWithCity:(WTCity *)city {
    self = [super init];
    
    if (self) {
        _title = city.name;
        _coordinate = CLLocationCoordinate2DMake([city.location.latitude doubleValue], [city.location.longitude doubleValue]);
    }
    
    return self;
}

@end
