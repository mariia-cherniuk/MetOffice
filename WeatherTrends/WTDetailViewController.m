//
//  WTDetailViewController.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTDetailViewController.h"
#import "WTYear.h"
#import "WTMonth.h"

#import <Charts/Charts-Swift.h>

@interface WTDetailViewController ()

@property (weak, nonatomic) IBOutlet HorizontalBarChartView *maxTempChartView;
@property (weak, nonatomic) IBOutlet HorizontalBarChartView *minTempChartView;
@property (weak, nonatomic) IBOutlet LineChartView *airFrostChartView;
@property (weak, nonatomic) IBOutlet BubbleChartView *rainfallChartView;
@property (weak, nonatomic) IBOutlet BarChartView *sunshineChartView;

@property (strong, nonatomic) NSArray *sortedMonths;

@end

@implementation WTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preapareData];
    [self configureMaxTempChartView];
    [self configureMinTempChartView];
    [self configureAirFrostChartView];
    [self configureRainfallChartView];
    [self configureSunshineChartView];
}

- (void)preapareData {
    _sortedMonths = [_year.months.allObjects sortedArrayUsingComparator:^NSComparisonResult(WTMonth *obj1, WTMonth *obj2) {
        return [@([obj1.number integerValue]) compare:@([obj2.number integerValue])];
    }];
}

- (void)configureMaxTempChartView {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 1;
    formatter.negativeSuffix = @" °C";
    formatter.positiveSuffix = @" °C";
    
    ChartXAxis *xAxis = _maxTempChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *leftAxis = _maxTempChartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis._axisMinimum = 0.0;
    leftAxis.valueFormatter = formatter;
    leftAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *rightAxis = _maxTempChartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis._axisMinimum = 0.0;
    rightAxis.valueFormatter = formatter;
    rightAxis.labelTextColor = [UIColor whiteColor];
    
    _maxTempChartView.legend.position = ChartLegendPositionBelowChartLeft;
    _maxTempChartView.legend.form = ChartLegendFormSquare;
    _maxTempChartView.legend.formSize = 8.0;
    _maxTempChartView.legend.font = [UIFont fontWithName:@"American Typewriter" size:11.f];
    _maxTempChartView.legend.xEntrySpace = 4.0;
    _maxTempChartView.descriptionText = @"";
    _maxTempChartView.legend.textColor = [UIColor whiteColor];
    [_maxTempChartView animateWithYAxisDuration:2.5];

    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < _sortedMonths.count; i++) {
        WTMonth *month = _sortedMonths[i];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[month.maxTemp integerValue]
                                                                     xIndex:i];
        
        [yVals addObject:entry];
    }
    NSArray *xVals = [_sortedMonths valueForKeyPath:@"number"];
    BarChartDataSet *dataSet = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Month / °C"];
    dataSet.colors = @[[UIColor redColor]];
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    _maxTempChartView.data = data;
    _maxTempChartView.backgroundColor = [UIColor clearColor];
}

- (void)configureMinTempChartView {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 1;
    formatter.negativeSuffix = @" °C";
    formatter.positiveSuffix = @" °C";
    
    ChartXAxis *xAxis = _minTempChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *leftAxis = _minTempChartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis._axisMinimum = 0.0;
    leftAxis.valueFormatter = formatter;
    leftAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *rightAxis = _minTempChartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis._axisMinimum = 0.0;
    rightAxis.valueFormatter = formatter;
    rightAxis.labelTextColor = [UIColor whiteColor];
    
    _minTempChartView.legend.position = ChartLegendPositionBelowChartLeft;
    _minTempChartView.legend.form = ChartLegendFormSquare;
    _minTempChartView.legend.formSize = 8.0;
    _minTempChartView.legend.font = [UIFont fontWithName:@"American Typewriter" size:11.f];
    _minTempChartView.legend.xEntrySpace = 4.0;
    _minTempChartView.descriptionText = @"";
    _minTempChartView.legend.textColor = [UIColor whiteColor];
    [_minTempChartView animateWithYAxisDuration:2.5];
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < _sortedMonths.count; i++) {
        WTMonth *month = _sortedMonths[i];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[month.minTemp integerValue] xIndex:i];
       
        [yVals addObject:entry];
    }
    NSArray *xVals = [_sortedMonths valueForKeyPath:@"number"];
    BarChartDataSet *dataSet = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Month / °C"];
    dataSet.colors = @[[UIColor blueColor]];
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    _minTempChartView.data = data;
    _minTempChartView.backgroundColor = [UIColor clearColor];
}

- (void)configureAirFrostChartView {
    NSNumberFormatter *daysFormatter = [[NSNumberFormatter alloc] init];
    daysFormatter.minimumFractionDigits = 0;
    daysFormatter.maximumFractionDigits = 0;
    daysFormatter.negativeSuffix = @" d";
    daysFormatter.positiveSuffix = @" d";
    
    ChartXAxis *xAxis = _airFrostChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *leftAxis = _airFrostChartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis._axisMinimum = 0.0;
    leftAxis.valueFormatter = daysFormatter;
    leftAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *rightAxis = _airFrostChartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis._axisMinimum = 0.0;
    rightAxis.valueFormatter = daysFormatter;
    rightAxis.labelTextColor = [UIColor whiteColor];
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < _sortedMonths.count; i++) {
        WTMonth *month = _sortedMonths[i];
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:[month.afDays integerValue] xIndex:i];
        
        [yVals addObject:entry];
    }
    NSArray *xVals = [_sortedMonths valueForKeyPath:@"number"];
    LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithYVals:yVals label:@"Days / Month"];
    dataSet.circleRadius = 4.0;
    dataSet.valueTextColor = [UIColor whiteColor];
    dataSet.colors = @[[UIColor blueColor]];
    LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    _airFrostChartView.data = data;
    _airFrostChartView.gridBackgroundColor = [UIColor whiteColor];
    _airFrostChartView.descriptionText = @"";
    _airFrostChartView.legend.textColor = [UIColor whiteColor];
    [_airFrostChartView animateWithYAxisDuration:2.5];
}

- (void)configureRainfallChartView {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 0;
    formatter.negativeSuffix = @" mm";
    formatter.positiveSuffix = @" mm";
    
    ChartXAxis *xAxis = _rainfallChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *leftAxis = _rainfallChartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis._axisMinimum = 0.0;
    leftAxis.valueFormatter = formatter;
    leftAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *rightAxis = _rainfallChartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis._axisMinimum = 0.0;
    rightAxis.valueFormatter = formatter;
    rightAxis.labelTextColor = [UIColor whiteColor];
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < _sortedMonths.count; i++) {
        WTMonth *month = _sortedMonths[i];
        BubbleChartDataEntry *entry = [[BubbleChartDataEntry alloc] initWithXIndex:i value:[month.rainAmount doubleValue] size:[month.rainAmount doubleValue]];
        [yVals addObject:entry];
    }
    NSArray *xVals = [_sortedMonths valueForKeyPath:@"number"];
    BubbleChartDataSet *dataSet = [[BubbleChartDataSet alloc] initWithYVals:yVals label:@"mm / Month"];
    dataSet.colors = @[[UIColor cyanColor]];
    BubbleChartData *data = [[BubbleChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    _rainfallChartView.data = data;
    _rainfallChartView.descriptionText = @"";
    _rainfallChartView.legend.textColor = [UIColor whiteColor];
    [_rainfallChartView animateWithYAxisDuration:2.5];
}

- (void)configureSunshineChartView {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 0;
    formatter.negativeSuffix = @" h";
    formatter.positiveSuffix = @" h";
    
    ChartXAxis *xAxis = _sunshineChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *leftAxis = _sunshineChartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis._axisMinimum = 0.0;
    leftAxis.valueFormatter = formatter;
    leftAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *rightAxis = _sunshineChartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis._axisMinimum = 0.0;
    rightAxis.valueFormatter = formatter;
    rightAxis.labelTextColor = [UIColor whiteColor];
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < _sortedMonths.count; i++) {
        WTMonth *month = _sortedMonths[i];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:[month.sunAmount doubleValue] xIndex:i];

        [yVals addObject:entry];
    }
    NSArray *xVals = [_sortedMonths valueForKeyPath:@"number"];
    BarChartDataSet *dataSet = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Hours / Month"];
    dataSet.colors = @[[UIColor yellowColor]];
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    _sunshineChartView.data = data;
    _sunshineChartView.descriptionText = @"";
    _sunshineChartView.legend.textColor = [UIColor whiteColor];
    [_sunshineChartView animateWithYAxisDuration:2.5];
}

@end
