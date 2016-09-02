//
//  AppDelegate.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "AppDelegate.h"
#import "WTCoreDataStack.h"
#import "WTDetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:0.800 green:1.000 blue:0.000 alpha:1.000],
                                                            NSFontAttributeName: [UIFont fontWithName:@"American Typewriter" size:20.0f]
                                                            }];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.800 green:1.000 blue:0.000 alpha:1.000]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    
    return YES;
}

//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    
//    UINavigationController *NC = (UINavigationController *)window.rootViewController;
//    
//    if ([NC.visibleViewController isKindOfClass:[WTDetailViewController class]]) {
//            return UIInterfaceOrientationMaskAll;
//        } else {
//            return UIInterfaceOrientationMaskPortrait;
//        }
//}

//func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
//    
//    if let navigationController = self.window?.rootViewController as? UINavigationController {
//        
//        if navigationController.visibleViewController is navigationController  {
//            return UIInterfaceOrientationMask.All
//        }
//        
//        else {
//            return UIInterfaceOrientationMask.Portrait
//        }
//    }
//    
//    return UIInterfaceOrientationMask.Portrait
//}
//
//
//
@end
