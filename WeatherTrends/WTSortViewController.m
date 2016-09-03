//
//  WTFilterViewController.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTSortViewController.h"
#import "WTYearSortConfiguration.h"
#import "WTSortControllerDeledate.h"

@interface WTSortViewController ()

@property (nonatomic, readwrite, strong) WTYearSortConfiguration *yearSortConfiguration;

@property (weak, nonatomic) IBOutlet UIImageView *filterResultImageView;

@end

@interface WTSortViewController ()

@end

@implementation WTSortViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    _filterResultImageView.image = [self imageFromName:@"calendar"];
    _yearSortConfiguration = [[WTYearSortConfiguration alloc] init];
}

#pragma mark - Actions

- (IBAction)ascendingDescendingSegmentedControlPressed:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        _yearSortConfiguration.ascending = NO;
    } else {
        _yearSortConfiguration.ascending = YES;
    }
}

- (IBAction)maxTempPressed:(UIButton *)sender {
    _filterResultImageView.image = [self imageFromName:@"max_temp64"];
    _yearSortConfiguration.sortValue = @"averageMaxTemp";
}

- (IBAction)minTempPressed:(UIButton *)sender {
    _filterResultImageView.image = [self imageFromName:@"min_temp64"];
    _yearSortConfiguration.sortValue = @"averageMinTemp";
}

- (IBAction)airFrostPressed:(UIButton *)sender {
    _filterResultImageView.image = [self imageFromName:@"air_frost"];
    _yearSortConfiguration.sortValue = @"averageAFDays";
}

- (IBAction)rainfallPressed:(UIButton *)sender {
    _filterResultImageView.image = [self imageFromName:@"rainfall48"];
    _yearSortConfiguration.sortValue = @"averageRainfall";
}

- (IBAction)sunshinePressed:(UIButton *)sender {
    _filterResultImageView.image = [self imageFromName:@"sunshine48"];
    _yearSortConfiguration.sortValue = @"averageSunshine";
}

- (IBAction)doneButtonPressed:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(sortViewController:didChangedSortConfiguration:)]) {
        [_delegate sortViewController:self didChangedSortConfiguration:_yearSortConfiguration];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)yearButtonPressed:(UIButton *)sender {
    _filterResultImageView.image = [self imageFromName:@"calendar"];
    _yearSortConfiguration.sortValue = @"number";
}

- (IBAction)canselButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper

- (UIImage *)imageFromName:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
