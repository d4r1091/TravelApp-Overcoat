//
//  FlightsController.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "FlightsController.h"
#import "APIClient.h"
#import "FlightModelMapper.h"
#import "Flight.h"

@implementation FlightsController

+ (void)getFlightsWithCompletionBlock:(void (^)(BOOL, NSArray *, NSError *))completionBlock {
    [[APIClient sharedInstance] getFlightsWithCompletionBlock:^(BOOL success, NSArray *flights, NSError *error) {
        
        NSMutableArray *flightsObj = [NSMutableArray array];
        if (success) {
            for (FlightModelMapper *aFlight in flights) {
                Flight *aFlightObj = [[Flight alloc] initWithAirlane:aFlight.airline
                                                       departureDate:aFlight.departureDate
                                                             arrival:aFlight.arrivalDate
                                                               price:aFlight.price
                                                    departureAirport:aFlight.departureAirport
                                                      arrivalAirport:aFlight.arrivalAirport];
                [flightsObj addObject:aFlightObj];
            }
        }
        completionBlock(success, flightsObj, error);
    }];
}

@end
