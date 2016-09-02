//
//  WTCityYearsTableViewController.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 31.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTCityData;

@interface WTCityYearsTableViewController : UITableViewController

@property (nonatomic, readwrite, strong) WTCityData *cityData;

@end
