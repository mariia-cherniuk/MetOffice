//
//  WTSortControllerDeledate.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 02.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTYearSortConfiguration.h"
@class WTSortViewController;

@protocol WTSortControllerDeledate <NSObject>

- (void)sortViewController:(WTSortViewController *)controller didChangedSortConfiguration:(WTYearSortConfiguration *)sortConfiguration;

@end
