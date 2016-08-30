//
//  NSManagedObjectContext+Tests.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "NSManagedObjectContext+Tests.h"

@implementation NSManagedObjectContext (Tests)

+ (NSManagedObjectContext *)WT_testManagedObjectContextWithBundle:(NSBundle *)bundle {
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    NSError *error;
    
    [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType
                                             configuration:nil
                                                       URL:nil
                                                   options:nil
                                                     error:&error];
    if (error != nil) {
        NSLog(@"Error: %@", error);
        return nil;
    }
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = persistentStoreCoordinator;
    
    return context;
}

@end
