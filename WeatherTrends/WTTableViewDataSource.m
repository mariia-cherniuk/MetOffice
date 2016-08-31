//
//  WTTableViewDataSource.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 30.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTTableViewDataSource.h"

@interface WTTableViewDataSource ()

@property (nonatomic, readwrite, copy) CellForRowAtIndexPathBlock cellForRowAtIndexPathBlock;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation WTTableViewDataSource

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)controller
                      cellForRowAtIndexPathBlock:(CellForRowAtIndexPathBlock)cellForRowAtIndexPathBlock {
    self = [super init];
    
    if (self) {
        _fetchedResultsController = controller;
        _cellForRowAtIndexPathBlock = cellForRowAtIndexPathBlock;
    }
    
    return self;
}

#pragma mark - Public

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return [_fetchedResultsController objectAtIndexPath:indexPath];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = _fetchedResultsController.sections[section];
    
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellForRowAtIndexPathBlock == nil) {
        return nil;
    }
    return _cellForRowAtIndexPathBlock(tableView, indexPath, [_fetchedResultsController objectAtIndexPath:indexPath]);
}

@end
