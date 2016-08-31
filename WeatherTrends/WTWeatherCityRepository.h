//
//  WTWeatherCityRepository.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <CoreData/CoreData.h>
@class WTCity;

@interface WTWeatherCityRepository : NSObject

+ (instancetype)sharedRepository;

- (instancetype)initWithMainContext:(NSManagedObjectContext *)mainContext
                                  writingContext:(NSManagedObjectContext *)writingContext;

- (void)getCityWithCompletionBlock:(void (^)(WTCity *city, NSError *error))completionBlock;

- (WTCity *)currentCity;

@end
