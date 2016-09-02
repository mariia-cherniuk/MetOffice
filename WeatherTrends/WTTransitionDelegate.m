//
//  WTTransitionDelegate.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTTransitionDelegate.h"

@implementation WTTransitionDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return _animator;
}

@end
