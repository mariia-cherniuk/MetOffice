//
//  WTYear.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTYear.h"
#import "WTCity.h"
#import "WTMonth.h"

@implementation WTYear

- (NSNumber *)averageMaxTemp {
    return [self.months valueForKeyPath:@"@avg.maxTemp"];
}

- (NSNumber *)averageMinTemp {
    return [self.months valueForKeyPath:@"@avg.minTemp"];
}

- (NSNumber *)averageAFDays {
    return [self.months valueForKeyPath:@"@avg.afDays"];
}

- (NSNumber *)averageRainfall {
    return [self.months valueForKeyPath:@"@avg.rainAmount"];
}

- (NSNumber *)averageSunshine {
    return [self.months valueForKeyPath:@"@avg.sunAmount"];
}

@end
