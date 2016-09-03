//
//  WTCityAnnotationTests.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 02.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WTCityAnnotation.h"
#import "WTCity.h"
#import "WTLocation.h"
#import "NSManagedObjectContext+Tests.h"

@interface WTCityAnnotationTests : XCTestCase

@end

@implementation WTCityAnnotationTests

- (void)testInitCityAnnotation {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSManagedObjectContext *context = [NSManagedObjectContext WT_testManagedObjectContextWithBundle:bundle];
    WTCity *city = [NSEntityDescription insertNewObjectForEntityForName:@"WTCity"
                                                 inManagedObjectContext:context];
    
    city.location = (WTLocation *)[NSEntityDescription insertNewObjectForEntityForName:@"WTLocation"
                                                  inManagedObjectContext:context];
    
    city.location.latitude = @"2";
    city.location.longitude = @"3";
    city.name = @"Kiev";

    WTCityAnnotation *cityAnnotation = [[WTCityAnnotation alloc] initWithCity:city];
    
    XCTAssertEqual(city.name, cityAnnotation.title);
    XCTAssertEqual(cityAnnotation.coordinate.longitude, [city.location.longitude floatValue]);
    XCTAssertEqual(cityAnnotation.coordinate.latitude, [city.location.latitude floatValue]);
}

@end
