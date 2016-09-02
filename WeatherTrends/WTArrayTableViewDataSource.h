//
//  WTArrayTableViewDataSource.h
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UITableViewCell* (^CellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath, id object);

@interface WTArrayTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, readwrite, assign) BOOL searchBarActive;
@property (nonatomic, readwrite, strong) NSArray *filteredList;

- (instancetype)initWithObjects:(NSArray *)objects cellForRowAtIndexPathBlock:(CellForRowAtIndexPathBlock)cellForRowAtIndexPathBlock;

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end
