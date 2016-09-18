//
//  HotelsController.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "HotelsController.h"
#import "APIClient.h"
#import "HotelModelMapper.h"
#import "Hotel.h"
#import "SDWebImageManager.h"

/*
 Decided to use an array for the controller's callbacks 
 even if the network returns only an Object not filled in an array.
 With this design, will be easier to modify only the network stack when the JSON's change.
 */

@implementation HotelsController

+ (void)getHotelsWithCompletionBlock:(void (^)(BOOL, NSArray*, NSError *))completionBlock {
    [[APIClient sharedInstance] getHotelsWithCompletionBlock:^(BOOL success, HotelModelMapper *anHotel, NSError *error) {
        NSMutableArray *hotelsObj = [NSMutableArray array];
        if (success) {
            Hotel *anHotelObj = [[Hotel alloc] initWithName:anHotel.name
                                              hotelLocation:anHotel.hotelLocation
                                           hotelDescription:anHotel.hotelDescription
                                                     images:anHotel.images
                                                     rating:anHotel.rating
                                                 facilities:anHotel.facilities];
            
            [hotelsObj addObject:anHotelObj];
        }
        completionBlock(success, hotelsObj, error);
    }];
}

+ (void)getHotelImageWithUrlString:(NSString *)urlString completionBlock:(void (^)(BOOL, UIImage*, NSError *))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:urlString]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                // with much type, I'll could implement the cacheType = .Memory (I know this notation is SwiftLike ;) )too
                                if (image) {
                                    completion(finished, image, error);
                                }
                            }];
    });
}

@end
