//
//  WTStartViewController.m
//  WeatherTrends
//
//  Created by Mariia Cherniuk on 29.08.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "WTStartViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MAPKit/MAPKit.h"
#import "WTWeatherParser.h"
#import "WTDownloader.h"
#import "WTCoreDataStack.h"
#import "WTCity.h"
#import "WTYear.h"
#import "WTLocation.h"
#import "WTCityAnnotation.h"
#import "WTWeatherCityRepository.h"
#import "WTTableViewDataSource.h"
#import "WTYearsWeatherTableViewCell.h"
#import "WTDetailViewController.h"

#define LATITUDINAL_METERS 12000

@interface WTStartViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *backgroundMapView;
@property (weak, nonatomic) IBOutlet UITableView *yearsWeatherTabelView;

@property (nonatomic, readwrite, strong) WTWeatherCityRepository *cityRepository;
@property (nonatomic, readwrite, strong) WTCity *city;
@property (nonatomic, readwrite, strong) WTTableViewDataSource *tableViewDataSource;
@property (nonatomic, readwrite, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, readwrite, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation WTStartViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [_yearsWeatherTabelView registerNib:[UINib nibWithNibName:@"WTYearsWeatherTableViewCell" bundle:nil] forCellReuseIdentifier:@"WTYearsWeatherTableViewCell"];
    [self loadDataIfNeeded];
}

#pragma mark - Custom accessors

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    _managedObjectContext = [[WTCoreDataStack sharedCoreDataStack] mainContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"city.name == %@", _city.name];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WTYear"
                                              inManagedObjectContext:_managedObjectContext];
    request.entity = entity;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:NO]];
    request.predicate = predicate;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:request
                                                             managedObjectContext:_managedObjectContext
                                                             sectionNameKeyPath:nil
                                                             cacheName:nil];
    _fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _fetchedResultsController;
}

#pragma mark - Private

- (void)loadDataIfNeeded {
    _city = [[WTWeatherCityRepository sharedRepository] currentCity];
    
    if (_city) {
        [self configureViews];
    } else {
        [self loadData];
    }
}

- (void)loadData {
    [[WTWeatherCityRepository sharedRepository] getCityWithCompletionBlock:^(WTCity *city, NSError *error) {
        _city = city;
        
        [self configureViews];
    }];
}

- (void)configureViews {
    self.navigationItem.title = _city.name;
    [self configureBackgroundMapView];
    [self configureYearsWeatherTabelView];
}

- (void)configureBackgroundMapView {
    CLLocationCoordinate2D locationCoordinate2D = CLLocationCoordinate2DMake([_city.location.latitude doubleValue], [_city.location.longitude doubleValue]);
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(locationCoordinate2D, LATITUDINAL_METERS, LATITUDINAL_METERS);
    WTCityAnnotation *annotation = [[WTCityAnnotation alloc] initWithCity:_city];
    
    [_backgroundMapView addAnnotation:annotation];
    _backgroundMapView.region = coordinateRegion;
}

- (void)configureYearsWeatherTabelView {
    _tableViewDataSource = [[WTTableViewDataSource alloc] initWithFetchedResultsController:self.fetchedResultsController cellForRowAtIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath, id object) {
        
        WTYearsWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WTYearsWeatherTableViewCell"];
        WTYear *year = object;

        [cell configureWithYear:year];
        
        return cell;
    }];
    
    _yearsWeatherTabelView.dataSource = _tableViewDataSource;
    _yearsWeatherTabelView.delegate = self;
    [_yearsWeatherTabelView reloadData];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WTDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WTDetailViewController"];
    
    detailViewController.year = [_tableViewDataSource objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
