//
//  FlightsViewController.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 14/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "FlightsViewController.h"
#import "FlightsTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>

// Adding UILibrary dependencies
#import "MTCardLayout.h"
#import "UICollectionView+CardLayout.h"
#import "UICollectionView+DraggableCardLayout.h"
#import "MTCardLayoutHelper.h"
#import "FlightsController.h"
#import "Flight.h"
#import "Utils.h"

@interface FlightsViewController () <UICollectionViewDataSource_Draggable, UICollectionViewDelegate_Draggable, FlightsTableViewCellProtocol>

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray * items;

@end

@implementation FlightsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchFlights];
}

#pragma mark - View Helper Methods

- (void)fetchFlights {
    __block FlightsViewController *_self = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [FlightsController getFlightsWithCompletionBlock:^(BOOL success, NSArray *flights, NSError *error) {
        [MBProgressHUD hideHUDForView:_self.view animated:YES];
        if (!error) {
            _items = [NSMutableArray arrayWithArray:flights];
            [_self.collectionView reloadData];
        } else {
            [Utils showAlertOnViewController:_self
                                 withMessage:error.localizedDescription];
        }
    }];
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlightsTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"flightCellIdentifier" forIndexPath:indexPath];
    cell.delegate = self;
    Flight *aFlight = _items[indexPath.row];
    [cell bindDataWithAirlane:aFlight.airline
                departureDate:aFlight.departureDate
                      arrival:aFlight.arrivalDate 
                        price:aFlight.price
             departureAirport:aFlight.departureAirport
               arrivalAirport:aFlight.arrivalAirport];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString * item = _items[fromIndexPath.item];
    [_items removeObjectAtIndex:fromIndexPath.item];
    [_items insertObject:item atIndex:toIndexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

- (BOOL)collectionView:(UICollectionView *)collectionView canDeleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UIView *)collectionView:(UICollectionView *)collectionView deletionIndicatorViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageName = (_collectionView.viewMode == MTCardLayoutViewModeDefault) ? @"delete_small" : @"delete";
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

- (void)collectionView:(UICollectionView *)collectionView deleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_items removeObjectAtIndex:indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didDeleteItemAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_collectionView setViewMode:MTCardLayoutViewModePresenting animated:YES completion:nil];
}

#pragma mark - FlightsTableViewCell Delegate

- (void)userDidClickedCloseButton:(FlightsTableViewCell *)cell {
    // do somenthing, eventually
    [_collectionView setViewMode:MTCardLayoutViewModeDefault animated:YES completion:nil];
}

@end
