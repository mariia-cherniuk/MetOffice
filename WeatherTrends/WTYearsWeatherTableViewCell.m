//
//  WTYearsWeatherTableViewCell.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTYearsWeatherTableViewCell.h"
#import "WTYear.h"

@implementation WTYearsWeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.maxTempImageView.image = [[UIImage imageNamed:@"max_temp"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.minTempImageView.image = [[UIImage imageNamed:@"min_temp"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.rainfallImageView.image = [[UIImage imageNamed:@"rainfall"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.sunshineImageView.image = [[UIImage imageNamed:@"sunshine"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.airFrostImageView.image = [[UIImage imageNamed:@"air_frost"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.4];
    self.selectedBackgroundView = backgroundView;
}

#pragma mark - Public

- (void)configureWithYear:(WTYear *)year {
//  KVC magic - http://nshipster.com/kvc-collection-operators/
    
    double averageMaxTemp = [year.averageMaxTemp doubleValue];
    double averageMinTemp = [year.averageMinTemp doubleValue];
    double averageAirFrost = [year.averageAFDays doubleValue];
    double averageSunshine = [year.averageSunshine doubleValue];
    double averageRainfall = [year.averageRainfall doubleValue];
    
    _yeasNumberLabel.text = [NSString stringWithFormat:@"%@ year", year.number];
    _maxTempLabel.text = [NSString stringWithFormat:@"Max Temp - %2.2f° C", averageMaxTemp];
    _minTempLabel.text = [NSString stringWithFormat:@"Min Temp - %2.2f° C", averageMinTemp];
    _airFrostLabel.text = [NSString stringWithFormat:@"Days of Air Frost - %2.2f days", averageAirFrost];
    _sunshineLabel.text = [NSString stringWithFormat:@"Sunshine - %2.2f hours", averageSunshine];
    _rainfallLabel.text = [NSString stringWithFormat:@"Rainfall - %2.2f mm", averageRainfall];
}

@end
