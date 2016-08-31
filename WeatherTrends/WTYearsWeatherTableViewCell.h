//
//  WTYearsWeatherTableViewCell.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTYear;

@interface WTYearsWeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *yeasNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *airFrostLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunshineLabel;
@property (weak, nonatomic) IBOutlet UILabel *rainfallLabel;
@property (weak, nonatomic) IBOutlet UIImageView *maxTempImageView;
@property (weak, nonatomic) IBOutlet UIImageView *airFrostImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sunshineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rainfallImageView;

@property (weak, nonatomic) IBOutlet UIImageView *minTempImageView;
- (void)configureWithYear:(WTYear *)year;

@end
