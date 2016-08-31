//
//  WTWeatherParser.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTWeatherParser.h"
#import "WTCoreDataStack.h"
#import "WTCity.h"
#import "WTLocation.h"
#import "WTYear.h"
#import "WTMonth.h"

@interface WTWeatherParser ()

@property (nonatomic, readwrite, strong) NSManagedObjectContext *writingContext;

@end

@implementation WTWeatherParser

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)writingContext {
    self = [super init];
    
    if (self) {
        _writingContext = writingContext;
    }
    
    return self;
}

- (WTCity *)parseWeatherData:(NSData *)weatherData {
    if (!weatherData) {
        return nil;
    }
    
    __block WTCity *city;
    [_writingContext performBlockAndWait:^{
        NSString *weatherDataString = [[NSString alloc] initWithData:weatherData encoding:NSUTF8StringEncoding];
        NSString *cityName = [self getCityNameFromWeatherDataString:weatherDataString];
        city = [self cityByName:cityName];
        
        if (!city) {
            NSString *locationSubstring = [self getLocationStringFromWeatherDataString:weatherDataString];
            WTLocation *location = [self parsedLacationFromComponents:locationSubstring];
            city = [self cityWithName:cityName location:location];
            
            NSString *yearMonthSubstring = [self getYearMonthStringFromWeatherDataString:weatherDataString];
            NSArray *yearMonthComponents = [yearMonthSubstring componentsSeparatedByString:@"\n"];
            NSArray *yearMonthWithoutEmptyComponents = [self arrayWithoutEmptyComponentsFromSourceArray:yearMonthComponents];
            NSRange yearsMonthRange = NSMakeRange(1, yearMonthWithoutEmptyComponents.count-1);
            NSArray *yearMonthWorkingArray = [yearMonthWithoutEmptyComponents subarrayWithRange:yearsMonthRange];
            
            [self parseYearComponents:yearMonthWorkingArray toCity:city];
        }
    }];
    return city;
}

- (NSString *)getCityNameFromWeatherDataString:(NSString *)string {
    NSRange range = [string rangeOfString:@"\n"];
    
    if (range.location != NSNotFound) {
         return [string substringToIndex:range.location];
    }
    
    return nil;
}

- (NSString *)getLocationStringFromWeatherDataString:(NSString *)string {
    NSRange range = [string rangeOfString:@"Location"];
    NSString *result;
    
    if (range.location != NSNotFound) {
        result = [string substringFromIndex:range.location];
        
        NSRange range = [result rangeOfString:@"Estimated"];
        
        if (range.location != NSNotFound) {
            return [result substringToIndex:range.location];
        }
    }
    
    return nil;
}

- (NSString *)getYearMonthStringFromWeatherDataString:(NSString *)string {
    NSRange range = [string rangeOfString:@"hours\n"];
    
    if (range.location != NSNotFound) {
        return [string substringFromIndex:range.location];
    }

    return nil;
}

- (WTLocation *)parsedLacationFromComponents:(NSString *)components {
    NSRange range = [components rangeOfString:@"Lat"];
    NSString *workingLocation;
    
    if (range.location != NSNotFound) {
        workingLocation = [components substringFromIndex:range.location];
    }

    NSArray *locationComponents = [workingLocation componentsSeparatedByString:@","];
    NSArray *latitudeLongitudeComponents = [self seperatedComponentsFromString:locationComponents[0]];
    WTLocation *location = [NSEntityDescription insertNewObjectForEntityForName:@"WTLocation"
                                                         inManagedObjectContext:_writingContext];
    
    location.latitude = latitudeLongitudeComponents[1];
    location.longitude = latitudeLongitudeComponents[3];
    location.metresAboveSea = locationComponents[locationComponents.count-1];

    return location;
}

- (WTCity *)cityWithName:(NSString *)name location:(WTLocation *)location {
    WTCity *city = [NSEntityDescription insertNewObjectForEntityForName:@"WTCity"
                                                         inManagedObjectContext:_writingContext];
    
    city.name = name;
    city.location = location;
    
    return city;
}

- (void)parseYearComponents:(NSArray *)components toCity:(WTCity *)city {
    NSInteger componentsCount = components.count;
    NSMutableSet *yearsSet = [[NSMutableSet alloc] init];
    NSString *currentYearNumber = @"";
    WTYear *year;
    
    for (NSInteger i = 0; i < componentsCount; i++) {
        NSArray *yearMonthComponents = [self seperatedComponentsFromString:components[i]];
        
        if (![currentYearNumber isEqualToString:yearMonthComponents[0]]) {
            year = [NSEntityDescription insertNewObjectForEntityForName:@"WTYear"
                                                 inManagedObjectContext:_writingContext];
            
            year.number = yearMonthComponents[0];
            currentYearNumber = year.number;
            
            [yearsSet addObject:year];
        }
        [year addMonthsObject:[self parsedMonthFromComponents:yearMonthComponents]];
    }
    [city addYears:yearsSet];
    [WTCoreDataStack saveChangesInContex:_writingContext];
}

- (WTMonth *)parsedMonthFromComponents:(NSArray *)components {
    WTMonth *month = [NSEntityDescription insertNewObjectForEntityForName:@"WTMonth"
                                                   inManagedObjectContext:_writingContext];
   
    month.number = components[1];
    month.maxTemp = components[2];
    month.minTemp = components[3];
    month.afDays = components[4];
    month.rainAmount = components[5];
    month.sunAmount = components[6];

    return month;
}

- (WTCity *)cityByName:(NSString *)cityName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", cityName];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WTCity"
                                              inManagedObjectContext:_writingContext];
    request.entity = entity;
    request.predicate = predicate;
    
    NSError *error = nil;
    WTCity *city = [[_writingContext executeFetchRequest:request error:&error] firstObject];
    
    if (error) {
        NSLog(@"%@", [error description]);
    }
    
    return city;
}

#pragma mark - Helper

- (NSArray *)arrayWithoutEmptyComponentsFromSourceArray:(NSArray *)source {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject,
                                                                   NSDictionary<NSString *,id> *bindings) {
        return evaluatedObject.length != 0;
    }];
    
    return [source filteredArrayUsingPredicate:predicate];
}

- (NSArray *)seperatedComponentsFromString:(NSString *)component {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    NSArray *yearMonthSeparatedComponents = [component componentsSeparatedByCharactersInSet:set];
    NSArray *yearMonthComponents = [self arrayWithoutEmptyComponentsFromSourceArray:yearMonthSeparatedComponents];
    
    return yearMonthComponents;
}

@end
