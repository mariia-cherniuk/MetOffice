//
//  WTDownloader.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTDownloader.h"

@implementation WTDownloader

+ (void)downloadDataByURL:(NSString *)urlStr
                 completionBlock:(void (^)(NSData *data, NSError *error))completionBlock {
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
       
//        Check for network error
        if (error) {
            NSLog(@"Error: Couldn't finish request: %@", error);
        } else if (statusCode < 200 || statusCode >= 300) {
//        Check for HTTP error
            NSLog(@"Error: Got stutus code %ld", (long)statusCode);
        } else if (data == nil) {
//        Check for data == nil error
            NSLog(@"Error: Data is nil");
        }
        
        if (completionBlock) {
            completionBlock(data, error);
        }
    }];
    [dataTask resume];
}

@end
