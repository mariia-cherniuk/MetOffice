//
//  MADFetchedResultsTableViewAdapter.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "UIKit/UIKit.h"
#import <CoreData/CoreData.h>

@interface MADFetchedResultsTableViewAdapter : NSObject <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)controller
                                       tableView:(UITableView *)tableView;

@end
