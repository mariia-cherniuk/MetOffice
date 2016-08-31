//
//  WTTableViewDataSource.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "UIKit/UIKit.h"
#import <CoreData/CoreData.h>

typedef UITableViewCell* (^CellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath, id object);

@interface WTTableViewDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)controller
                      cellForRowAtIndexPathBlock:(CellForRowAtIndexPathBlock)cellForRowAtIndexPathBlock;

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end
