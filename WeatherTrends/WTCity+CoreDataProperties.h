//
//  WTCity+CoreDataProperties.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WTCity.h"

NS_ASSUME_NONNULL_BEGIN

@interface WTCity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) WTLocation *location;
@property (nullable, nonatomic, retain) NSSet<WTYear *> *years;

@end

@interface WTCity (CoreDataGeneratedAccessors)

- (void)addYearsObject:(WTYear *)value;
- (void)removeYearsObject:(WTYear *)value;
- (void)addYears:(NSSet<WTYear *> *)values;
- (void)removeYears:(NSSet<WTYear *> *)values;

@end

NS_ASSUME_NONNULL_END
