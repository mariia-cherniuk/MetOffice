//
//  WTLocation+CoreDataProperties.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WTLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface WTLocation (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *latitude;
@property (nullable, nonatomic, retain) NSString *longitude;
@property (nullable, nonatomic, retain) NSString *metresAboveSea;
@property (nullable, nonatomic, retain) WTCity *city;

@end

NS_ASSUME_NONNULL_END
