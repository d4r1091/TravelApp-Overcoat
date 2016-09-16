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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HotelsController getHotelsWithCompletionBlock:^(BOOL success, Hotel *hotel, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            _items = [NSMutableArray arrayWithObject:hotel];
            [_self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotelCellIdentifier" forIndexPath:indexPath];
    // Configure the cell...
    Hotel *anHotel = _items[indexPath.row];
    cell.textLabel.text = anHotel.name;
    return cell;
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
