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

@implementation HotelsController

+ (void)getHotelsWithCompletionBlock:(void (^)(BOOL, Hotel *, NSError *))completionBlock {
    [[APIClient sharedInstance] getHotelsWithCompletionBlock:^(BOOL success, HotelModelMapper *anHotel, NSError *error) {
        Hotel *anHotelObj = [[Hotel alloc] initWithName:anHotel.name
                                          hotelLocation:anHotel.hotelLocation
                                       hotelDescription:anHotel.hotelDescription
                                                 images:anHotel.images
                                                 rating:anHotel.rating
                                             facilities:anHotel.facilities];
        completionBlock(success, anHotelObj, error);
    }];
}

+ (void)getHotelImageWithUrlString:(NSString *)urlString completionBlock:(void (^)(BOOL, UIImage*, NSError *))completion {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:urlString]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                completion(finished, image, error);
                            }
                        }];
}

@end
