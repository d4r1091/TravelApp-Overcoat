//
//  Flight.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "Flight.h"

@implementation Flight

- (instancetype)initWithAirlane:(NSString *) airlane
                  departureDate:(NSDate *)departure
                        arrival:(NSDate *)arrival
                          price:(NSUInteger)price
               departureAirport:(NSString *)departureAirport
                 arrivalAirport:(NSString *)arrivalAirport {
    self = [super init];
    if (self) {
        _airline = airlane;
        _departureDate = departure;
        _arrivalDate = arrival;
        _price = price;
        _departureAirport = departureAirport;
        _arrivalAirport = arrivalAirport;
    }
    return self;
}


@end
