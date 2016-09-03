//
//  WTArrayTableViewDataSource.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTArrayTableViewDataSource.h"

@interface WTArrayTableViewDataSource ()

@property (nonatomic, readwrite, strong) NSArray *objects;
@property (nonatomic, copy) CellForRowAtIndexPathBlock cellForRowAtIndexPathBlock;

@end

@implementation WTArrayTableViewDataSource

- (instancetype)initWithObjects:(NSArray *)objects cellForRowAtIndexPathBlock:(CellForRowAtIndexPathBlock)cellForRowAtIndexPathBlock {
    self = [super init];
    
    if (self) {
        self.objects = objects;
        self.cellForRowAtIndexPathBlock = cellForRowAtIndexPathBlock;
    }
    
    return self;
}

#pragma mark - Public

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    if (_searchBarActive) {
        return _filteredList[indexPath.row];
    }
    return _objects[indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchBarActive) {
        return _filteredList.count;
    }
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellForRowAtIndexPathBlock == nil) {
        return nil;
    }
    return _cellForRowAtIndexPathBlock(tableView, indexPath, [self objectAtIndexPath:indexPath]);
}

@end
