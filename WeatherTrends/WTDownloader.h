//
//  WTDownloader.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTDownloader : NSObject

+ (void)downloadDataByURL:(NSString *)urlStr
                 completionBlock:(void (^)(NSData *data, NSError *error))completionBlock;

@end
