//
//  FlightModelMapper.h
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <Overcoat/OVCResponse.h>

/* Serializing this model
 {
 "airline": "FastJet",
 "departure_date": "2016-10-20T10:50:00Z",
 "arrival_date": "2016-10-20T11:50:00Z",
 "price": 13300,
 "departure_airport": "London Gatwick",
 "arrival_airport": "Girona"
 },
 */

@interface FlightModelMapper : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *airline;
@property (nonatomic, readonly, strong) NSDate *departureDate;
@property (nonatomic, assign, readonly) NSUInteger price;
@property (nonatomic, readonly, strong) NSDate *arrivalDate;
@property (nonatomic, readonly, copy) NSString *departureAirport;
@property (nonatomic, readonly, copy) NSString *arrivalAirport;

@end

@interface FlightsResponse : OVCResponse

@end