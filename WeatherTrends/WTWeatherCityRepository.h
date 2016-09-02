//
//  WTWeatherCityRepository.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <CoreData/CoreData.h>
@class WTCity;
@class WTCityData;

@interface WTWeatherCityRepository : NSObject

+ (instancetype)sharedRepository;

- (instancetype)initWithMainContext:(NSManagedObjectContext *)mainContext
                                  writingContext:(NSManagedObjectContext *)writingContext;

- (void)getCityForCityData:(WTCityData *)cityData
           completionBlock:(void (^)(WTCity *city, NSError *error))completionBlock;

@end
