//
//  WTWeatherParser.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <CoreData/CoreData.h>
@class WTCity;

@interface WTWeatherParser : NSObject

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)writingContext;
- (WTCity *)parseWeatherData:(NSData *)weatherData;

@end
