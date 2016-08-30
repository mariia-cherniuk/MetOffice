//
//  ViewController.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "ViewController.h"
#import "WTWeatherParser.h"
#import "WTDownloader.h"
#import "WTCoreDataStack.h"

static NSString *WTBaseURL = @"http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [WTDownloader downloadDataByURL:WTBaseURL completionBlock:^(NSData *data, NSError *error) {
        WTWeatherParser *weatherParser = [[WTWeatherParser alloc] initWithManagedObjectContext:[[WTCoreDataStack sharedCoreDataStack] writingContext]];
        [weatherParser parseWeatherData:data];
    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
