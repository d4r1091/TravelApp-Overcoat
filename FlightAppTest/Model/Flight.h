//
//  Flight.h
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flight : NSObject

@property (nonatomic, readonly, copy) NSString *airline;
@property (nonatomic, readonly, strong) NSDate *departureDate;
@property (nonatomic, assign, readonly) NSUInteger price;
@property (nonatomic, readonly, strong) NSDate *arrivalDate;
@property (nonatomic, readonly, copy) NSString *departureAirport;
@property (nonatomic, readonly, copy) NSString *arrivalAirport;


- (instancetype)initWithAirlane:(NSString *) airlane
                  departureDate:(NSDate *)departure
                        arrival:(NSDate *)arrival
                          price:(NSUInteger)price
               departureAirport:(NSString *)departureAirport
                 arrivalAirport:(NSString *)arrivalAirport;
@end
