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

+ (WTCity *)WT_findFirsInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WTCity"
                                              inManagedObjectContext:context];
    request.entity = entity;

    return [[context executeFetchRequest:request error:nil] firstObject];
}

@end
