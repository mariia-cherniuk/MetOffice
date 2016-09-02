//
//  WTFilterViewController.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WTSortControllerDeledate;

@interface WTSortViewController : UIViewController

@property (weak, nonatomic, readwrite) id <WTSortControllerDeledate> delegate;

@end
