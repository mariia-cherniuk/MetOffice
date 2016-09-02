//
//  WTCityData.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTCityData : NSObject

@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *url;

+ (NSArray *)citiesData;

- (instancetype)initWithName:(NSString *)name url:(NSString *)url;

@end
