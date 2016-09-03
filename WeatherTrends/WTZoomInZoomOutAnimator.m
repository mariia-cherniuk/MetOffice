//
//  WTZoomInZoomOutAnimator.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTZoomInZoomOutAnimator.h"

@implementation WTZoomInZoomOutAnimator

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BOOL isPresenting = toViewController.presentedViewController != fromViewController;
    
    if (isPresenting) {
        UIView *container = [transitionContext containerView];
        toViewController.view.layer.affineTransform = CGAffineTransformMakeScale(3.f, 3.f);
        toViewController.view.alpha = 0.f;
        toViewController.view.layer.cornerRadius = 8.f;
        container.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.399];
        toViewController.view.alpha = 0.f;
        
        [container addSubview:toViewController.view];
        [self createConstraintSubview:toViewController.view superview:container];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toViewController.view.alpha = 1.f;
                             toViewController.view.layer.affineTransform = CGAffineTransformMakeScale(1.f, 1.f);
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    } else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             fromViewController.view.alpha = 0.f;
                             fromViewController.view.layer.affineTransform = CGAffineTransformMakeScale(3.f, 3.f);
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private

- (void)createConstraintSubview:(UIView *)subview superview:(UIView *)superview {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat topConstant = [self topConstantForOrientation:orientation];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:subview
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:superview
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.f
                                                                      constant:topConstant];
    
    [superview addConstraint:topConstraint];
    
    CGFloat leadingConstant = [self leadingConstantForOrientation:orientation];
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:subview
                                                       attribute:NSLayoutAttributeLeading
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superview
                                                       attribute:NSLayoutAttributeLeading
                                                      multiplier:1.f
                                                        constant:leadingConstant];
    
    [superview addConstraint:leadingConstraint];
    
    CGFloat trailingConstant = [self trailingConstantForOrientation:orientation];
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:subview
                                                       attribute:NSLayoutAttributeTrailing
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superview
                                                       attribute:NSLayoutAttributeTrailing
                                                      multiplier:1.f
                                                        constant:trailingConstant];
    
    [superview addConstraint:trailingConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:subview
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:superview
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.f
                                                                         constant:-30.f];
    [superview addConstraint:bottomConstraint];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillChangeStatusBarOrientationNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        UIInterfaceOrientation orientation = [self orientationFromNotification:note];
        
        topConstraint.constant = [self topConstantForOrientation:orientation];
        trailingConstraint.constant = [self trailingConstantForOrientation:orientation];
        leadingConstraint.constant = [self leadingConstantForOrientation:orientation];
        bottomConstraint.constant = [self bottomConstantForOrientation:orientation];
    }];
}

- (UIInterfaceOrientation)orientationFromNotification:(NSNotification *)note {
    NSDictionary *info = note.userInfo;
    
    return [info[UIApplicationStatusBarOrientationUserInfoKey] integerValue];
}

- (CGFloat)topConstantForOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return 54.f;
    } else {
        return 94.f;
    }
}

- (CGFloat)trailingConstantForOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return -120.f;
    } else {
        return -30.f;
    }
}

- (CGFloat)leadingConstantForOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return 120.f;
    } else {
        return 30.f;
    }
}

- (CGFloat)bottomConstantForOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return -20.f;
    } else {
        return -30.f;
    }
}

@end
