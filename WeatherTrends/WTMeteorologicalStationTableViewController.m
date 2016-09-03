//
//  WTMeteorologicalStationTableViewController.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 01.09.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTMeteorologicalStationTableViewController.h"
#import "WTArrayTableViewDataSource.h"
#import "WTCityYearsTableViewController.h"
#import "WTMeteorologicalStationTableViewCell.h"
#import "WTCityData.h"

@interface WTMeteorologicalStationTableViewController () <UISearchBarDelegate>

@property (strong, nonatomic, readwrite) NSArray *meteorologicalStations;
@property (strong, nonatomic, readwrite) WTArrayTableViewDataSource *dataSource;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation WTMeteorologicalStationTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Meteorological Stations";
    self.tableView.backgroundView = _backgroundImageView;
    self.tableView.tableHeaderView = _searchBar;
    _searchBar.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"WTMeteorologicalStationTableViewCell" bundle:nil] forCellReuseIdentifier:@"WTMeteorologicalStationTableViewCell"];
    
    _meteorologicalStations = [WTCityData citiesData];
    [self configureTabelView];
}

#pragma mark - Private

- (void)configureTabelView {
    _dataSource = [[WTArrayTableViewDataSource alloc] initWithObjects:_meteorologicalStations cellForRowAtIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath, id object) {
        WTMeteorologicalStationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WTMeteorologicalStationTableViewCell"];
        WTCityData *cityData = object;
        
        cell.stationName.text = cityData.name;
        
        return cell;
    }];
    
    self.tableView.dataSource = _dataSource;
}

#pragma mark - Tabel View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WTCityYearsTableViewController *masterTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WTMasterTableViewController"];
    
    masterTVC.cityData = [_dataSource objectAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:masterTVC animated:YES];
}

#pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _dataSource.searchBarActive = YES;
    [_searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length > 0) {
        _dataSource.searchBarActive = YES;
        [self filterContentForSearchText:searchText];
    } else {
        _dataSource.searchBarActive = NO;
    }
    [self.tableView reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText];
    
    _dataSource.filteredList = [_meteorologicalStations filteredArrayUsingPredicate:predicate];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}

@end
