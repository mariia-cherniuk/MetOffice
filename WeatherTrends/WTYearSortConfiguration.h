//
//  WTYearSortConfiguration.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 02.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTYearSortConfiguration : NSObject

@property (nonatomic, readwrite, assign) BOOL ascending;
@property (nonatomic, readwrite, strong) NSString *sortValue;

@end
