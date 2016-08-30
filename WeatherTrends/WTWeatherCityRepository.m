//
//  WTWeatherCityRepository.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTWeatherCityRepository.h"
#import "WTCoreDataStack.h"
#import "WTDownloader.h"
#import "WTWeatherParser.h"
#import "WTCity.h"

static NSString *WTBaseURL = @"http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt";

@interface WTWeatherCityRepository ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *mainContext;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *writingContext;

@end

@implementation WTWeatherCityRepository

+ (instancetype)sharedRepository {
    static dispatch_once_t onceToken;
    static WTWeatherCityRepository *sharedRepository;
    
    dispatch_once(&onceToken, ^{
        sharedRepository = [[WTWeatherCityRepository alloc] initWithMainContext:[WTCoreDataStack sharedCoreDataStack].mainContext writingContext:[WTCoreDataStack sharedCoreDataStack].writingContext];
    });
    
    return sharedRepository;
}

- (instancetype)initWithMainContext:(NSManagedObjectContext *)mainContext
                                  writingContext:(NSManagedObjectContext *)writingContext {
    self = [super init];
    
    if (self) {
        _mainContext = mainContext;
        _writingContext = writingContext;
    }
    
    return self;
}

- (void)getCityWithCompletionBlock:(void (^)(WTCity *city, NSError *error))completionBlock {
    [WTDownloader downloadDataByURL:WTBaseURL completionBlock:^(NSData *data, NSError *error) {
        WTWeatherParser *weatherParser = [[WTWeatherParser alloc] initWithManagedObjectContext:_writingContext];
        WTCity *city = [weatherParser parseWeatherData:data];
        NSManagedObjectID *cityId = city.objectID;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            WTCity *city = [_mainContext objectWithID:cityId];
            
            if (completionBlock) {
                completionBlock(city, error);
            }
        });
    }];
}

- (WTCity *)currentCity {
    return [WTCity WT_findFirsInContext:_mainContext];
}

@end
