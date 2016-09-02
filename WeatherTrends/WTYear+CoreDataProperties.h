//
//  WTYear+CoreDataProperties.h
//  WeatherTrends
//  
//  Created by Mariia Cherniuk on 02.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WTYear.h"

NS_ASSUME_NONNULL_BEGIN

@interface WTYear (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *number;
@property (nullable, nonatomic, retain) NSNumber *averageMaxTemp;
@property (nullable, nonatomic, retain) NSNumber *averageMinTemp;
@property (nullable, nonatomic, retain) NSNumber *averageAFDays;
@property (nullable, nonatomic, retain) NSNumber *averageRainfall;
@property (nullable, nonatomic, retain) NSNumber *averageSunshine;
@property (nullable, nonatomic, retain) WTCity *city;
@property (nullable, nonatomic, retain) NSSet<WTMonth *> *months;

@end

@interface WTYear (CoreDataGeneratedAccessors)

- (void)addMonthsObject:(WTMonth *)value;
- (void)removeMonthsObject:(WTMonth *)value;
- (void)addMonths:(NSSet<WTMonth *> *)values;
- (void)removeMonths:(NSSet<WTMonth *> *)values;

@end

NS_ASSUME_NONNULL_END
