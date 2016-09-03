//
//  WTCityDataTests.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 02.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WTCityData.h"

@interface WTCityDataTests : XCTestCase

@end

@implementation WTCityDataTests

- (void)testCitiesData {
    NSArray *cities = [WTCityData citiesData];
    
    XCTAssertGreaterThan(cities.count, 0);
    
    for (WTCityData *cityData in cities) {
        XCTAssertNotNil(cityData.name);
        XCTAssertNotNil(cityData.url);
        
        XCTAssertNotNil([NSURL URLWithString:cityData.url]);
    }
}

@end
