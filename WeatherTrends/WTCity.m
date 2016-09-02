//
//  WTCity.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTCity.h"
#import "WTLocation.h"
#import "WTYear.h"

@implementation WTCity

+ (WTCity *)WT_findFirsInContext:(NSManagedObjectContext *)context forName:(NSString *)name {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WTCity"
                                              inManagedObjectContext:context];
    request.entity = entity;
    request.predicate = predicate;
    
    NSError *error = nil;
    WTCity *city = [[context executeFetchRequest:request error:&error] firstObject];
    
    if (error) {
        NSLog(@"%@", [error description]);
    }
    
    return city;
}

@end
