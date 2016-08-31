//
//  WTMonth+CoreDataProperties.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WTMonth.h"

NS_ASSUME_NONNULL_BEGIN

@interface WTMonth (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *number;
@property (nullable, nonatomic, retain) NSString *maxTemp;
@property (nullable, nonatomic, retain) NSString *minTemp;
@property (nullable, nonatomic, retain) NSString *afDays;
@property (nullable, nonatomic, retain) NSString *rainAmount;
@property (nullable, nonatomic, retain) NSString *sunAmount;
@property (nullable, nonatomic, retain) WTYear *year;

@end

NS_ASSUME_NONNULL_END
