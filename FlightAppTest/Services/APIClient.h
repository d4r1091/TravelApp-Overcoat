//
//  APIClient.h
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import <Overcoat/Overcoat.h>

@class HotelModelMapper;
@interface APIClient : OVCHTTPSessionManager

+ (id)sharedInstance;

- (void)getFlightsWithCompletionBlock:(void (^)(BOOL success, NSArray *flights, NSError *error))completionBlock;
- (void)getHotelsWithCompletionBlock:(void (^)(BOOL, HotelModelMapper *, NSError *))completionBlock;

@end
