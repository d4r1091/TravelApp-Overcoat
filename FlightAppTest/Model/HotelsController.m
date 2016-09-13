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

@implementation HotelsController

+ (void)getHotelsWithCompletionBlock:(void (^)(BOOL, NSArray *, NSError *))completionBlock {
    [[APIClient sharedInstance] getHotelsWithCompletionBlock:^(BOOL success, NSArray *hotels, NSError *error) {
        
        NSMutableArray *hotelsObj = [NSMutableArray array];
        if (success) {
            for (HotelModelMapper *anHotel in hotels) {
                Hotel *anHotelObj = [[Hotel alloc] initWithName:anHotel.name
                                                  hotelLocation:anHotel.hotelLocation
                                               hotelDescription:anHotel.hotelDescription
                                                         images:anHotel.images
                                                         rating:anHotel.rating
                                                     facilities:anHotel.facilities];
                
                [hotelsObj addObject:anHotelObj];
            }
        }
        completionBlock(success, hotelsObj, error);
        
    }];
}

@end
