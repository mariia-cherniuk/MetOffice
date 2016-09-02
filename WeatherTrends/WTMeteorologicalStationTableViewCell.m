//
//  WTMeteorologicalStationTableViewCell.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 02.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTMeteorologicalStationTableViewCell.h"

@implementation WTMeteorologicalStationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.4];
    self.selectedBackgroundView = backgroundView;
}

@end
