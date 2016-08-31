//
//  WTDetailViewController.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTYear;

@interface WTDetailViewController : UIViewController

@property (nonatomic, readwrite, strong) WTYear *year;

@end
