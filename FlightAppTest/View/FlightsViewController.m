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

@interface FlightsViewController () <UICollectionViewDataSource_Draggable, UICollectionViewDelegate_Draggable>

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray * items;

@end

@implementation FlightsViewController

#pragma mark Status Bar color

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - View Lifecycle

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_collectionView setViewMode:MTCardLayoutViewModePresenting animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __block FlightsViewController *_self = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [FlightsController getFlightsWithCompletionBlock:^(BOOL success, NSArray *flights, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            _items = [NSMutableArray arrayWithArray:flights];
            [_self.collectionView reloadData];
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
@end
