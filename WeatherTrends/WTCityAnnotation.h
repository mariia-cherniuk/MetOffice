//
//  WTCityAnnotation.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@class WTCity;

@interface WTCityAnnotation : NSObject <MKAnnotation>

@property (copy, nonatomic, readwrite) NSString *title;
@property (assign, nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (instancetype)initWithCity:(WTCity *)city;

@end
