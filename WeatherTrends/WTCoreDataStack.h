//
//  WTCoreDataStack.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface WTCoreDataStack : NSObject

@property (nonatomic, readwrite, strong) NSManagedObjectContext *mainContext;
@property (nonatomic, readwrite, strong) NSManagedObjectContext *writingContext;
@property (nonatomic, readwrite, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readwrite, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedCoreDataStack;
+ (void)saveChangesInContex:(NSManagedObjectContext *)context;

@end
