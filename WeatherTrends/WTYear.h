//
//  WTYear.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WTCity, WTMonth;

NS_ASSUME_NONNULL_BEGIN

@interface WTYear : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (NSNumber *)averageMaxTemp;
- (NSNumber *)averageMinTemp;
- (NSNumber *)averageAFDays;
- (NSNumber *)averageRainfall;
- (NSNumber *)averageSunshine;


@end

NS_ASSUME_NONNULL_END

#import "WTYear+CoreDataProperties.h"
