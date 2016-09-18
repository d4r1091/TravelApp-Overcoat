//
//  HotelsTableViewController.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 16/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "HotelsTableViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "HotelsController.h"
#import "Hotel.h"
#import "HotelDetailViewController.h"
#import "Utils.h"

/*
 Decided to use a tableview even if the network returns only an Object 
 not filled in an array. It will could make the view more scalable
 */

@interface HotelsTableViewController ()

@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, strong) Hotel *selectedHotel;

@end

@implementation HotelsTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchHotels];
}

#pragma mark - View Helper Methods

- (void)fetchHotels {
    __block HotelsTableViewController *_self = self;
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    [HotelsController getHotelsWithCompletionBlock:^(BOOL success, NSArray *hotels, NSError *error) {
        [MBProgressHUD hideHUDForView:_self.view
                             animated:YES];
        if (!error && hotels.count>0) {
            _items = [NSMutableArray arrayWithArray:hotels];
            [_self.tableView reloadData];
        } else {
            [Utils showAlertOnViewController:self
                                 withMessage:error.localizedDescription];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count?_items.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_items.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotelCellIdentifier" forIndexPath:indexPath];
        // Configure the cell...
        Hotel *anHotel = _items[indexPath.row];
        cell.textLabel.text = anHotel.name;
        return cell;
    } else {
        static NSString *noNotificationsCellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noNotificationsCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noNotificationsCellIdentifier];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"there are no offerts available right now";
        cell.userInteractionEnabled = NO;
        return cell;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedHotel = _items[indexPath.row];
    return indexPath;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToHotelDetailIdentifier"]) {
        HotelDetailViewController *hotelDetail = segue.destinationViewController;
        hotelDetail.hotel = _selectedHotel;
    }
}

@end
