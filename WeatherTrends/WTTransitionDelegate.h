//
//  WTTransitionDelegate.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, readwrite, strong) id <UIViewControllerAnimatedTransitioning> animator;

@end
