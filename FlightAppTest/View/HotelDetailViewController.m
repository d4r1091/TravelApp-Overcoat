//
//  HotelDetailViewController.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 16/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "Hotel.h"
#import "HotelsController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "SwipeView.h"

@interface HotelDetailViewController () <UITableViewDelegate, UITableViewDataSource, SwipeViewDataSource, SwipeViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *hotelDescription;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet SwipeView *imagesContainterSwipeView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UITableView *facilitiesTableView;
@property (nonatomic, strong) NSMutableArray *imagesArray;

@end

@implementation HotelDetailViewController
{
    BOOL pageControlBeingUsed;
}
#pragma mark - ViewLifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self setupSwipeView];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fillViewComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Helper Methods

- (void)fillViewComponents {
    _name.text = _hotel.name;
    _hotelDescription.text = _hotel.hotelDescription;
    
    //TODO: debug why XIB setting doesn't work itself
    _hotelDescription.font = [UIFont systemFontOfSize:20.0];
    
    _location.text = _hotel.hotelLocation;
    _rating.text = [NSString stringWithFormat:@"%li/5", _hotel.rating];
    _pageControl.numberOfPages = _hotel.facilities.count;
}

- (void)setupSwipeView {
    if (_hotel.images.count) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:_imagesContainterSwipeView
                                 animated:YES];
        });
        for (int i=0; i<_hotel.images.count; i++) {
            [self fetchImageAtIndex:i];
        }
    }
}

- (void)fetchImageAtIndex:(NSUInteger)index {
    __block HotelDetailViewController *_self = self;
    [HotelsController getHotelImageWithUrlString:_hotel.images[index]
                                 completionBlock:^(BOOL success, UIImage *image, NSError *error) {
                                     if (image) {
                                         if (!_self.imagesArray) {
                                             _self.imagesArray = [NSMutableArray array];
                                         }
                                         [_self.imagesArray addObject:image];
                                         if (index == _hotel.images.count-1) {
                                             [_self.imagesContainterSwipeView reloadData];
                                             [MBProgressHUD hideHUDForView:_self.imagesContainterSwipeView
                                                                  animated:YES];
                                         }
                                     }
                                 }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _hotel.facilities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"facilitiesCellIdentifier"];
    cell.textLabel.text = _hotel.facilities[indexPath.row];
    return cell;
}

#pragma mark - UISwipeViewDataSource & Delegate

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    //return the total number of items in the carousel
    return _hotel.images.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *imageView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:_imagesContainterSwipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        imageView.tag = 1;
        [view addSubview:imageView];
    }
    else
    {
        //get a reference to the imageView in the recycled view
        imageView = (UIImageView *)[view viewWithTag:1];
    }
    
    imageView.image = _imagesArray[index];
    
    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return _imagesContainterSwipeView.bounds.size;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView {
    _pageControl.currentPage = swipeView.currentPage;
}

@end
