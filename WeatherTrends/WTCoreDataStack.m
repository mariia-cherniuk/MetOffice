//
//  WTCoreDataStack.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTCoreDataStack.h"

@implementation WTCoreDataStack

+ (instancetype)sharedCoreDataStack {
    static WTCoreDataStack *coreDataStack = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        coreDataStack = [[WTCoreDataStack alloc] init];
    });
    
    return coreDataStack;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(contextDidSaveNotification:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - Private

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] firstObject];
}

#pragma mark - Notifications

- (void)contextDidSaveNotification:(NSNotification *)notification {
    if (self.managedObjectContext != notification.object) {
        [self.managedObjectContext performBlock:^{
            [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}

#pragma mark - Core Data Stack

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSURL *url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"WeatherTrendsModel" ofType:@"momd"]];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WeatherTrends.sqlite"];
    NSError *error;
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error]) {
        NSLog(@"%@", [error description]);
    }
    
    NSLog(@"%@", storeURL);
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    return _managedObjectContext;
}

- (NSManagedObjectContext *)writingContext {
    if (_writingContext) {
        return _writingContext;
    }
    
    _writingContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    _writingContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    return _writingContext;
}


+ (void)saveChangesInContex:(NSManagedObjectContext *)context {
    NSError *error;
    
    if (![context save:&error]) {
        NSLog(@"%@", [error description]);
    }
}


@end
