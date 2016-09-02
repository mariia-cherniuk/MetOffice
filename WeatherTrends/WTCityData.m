//
//  WTCityData.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTCityData.h"

@implementation WTCityData

+ (NSArray *)citiesData {
    NSURL *url = [[NSBundle bundleForClass:self] URLForResource:@"MeteorologicalStationList" withExtension:@"plist"];
    NSArray *meteorologicalStationsArray = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *meteorologicalStations = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < meteorologicalStationsArray.count - 1; i++) {
        NSString *cityName = [meteorologicalStationsArray[i] valueForKeyPath:@"name"];
        NSString *url = [meteorologicalStationsArray[i] valueForKeyPath:@"url"];
        WTCityData *cityData = [[WTCityData alloc] initWithName:cityName url:url];
        
        [meteorologicalStations addObject:cityData];
    }
    
    return meteorologicalStations;
}

- (instancetype)initWithName:(NSString *)name url:(NSString *)url {
    self = [super init];
    
    if (self) {
        _name = name;
        _url = url;
    }
    
    return self;
}

@end
