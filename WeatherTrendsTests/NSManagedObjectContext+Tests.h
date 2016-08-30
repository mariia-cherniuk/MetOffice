//
//  NSManagedObjectContext+Tests.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Tests)

+ (NSManagedObjectContext *)WT_testManagedObjectContextWithBundle:(NSBundle *)bundle;

@end
