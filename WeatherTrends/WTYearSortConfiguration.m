//
//  WTYearSortConfiguration.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 02.02.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTYearSortConfiguration.h"

@implementation WTYearSortConfiguration

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _sortValue = @"number";
    }

    return self;
}
@end
