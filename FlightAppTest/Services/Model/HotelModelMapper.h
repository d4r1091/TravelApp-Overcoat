//
//  HotelModelMapper.h
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <Overcoat/OVCResponse.h>

/* Serializing this model
 {
 "name": "Labranda Isla Bonita Hotel",
 "hotel_location": "Costa Adeje, Tenerife, Canaries",
 "description": "On the Beach Offer - Save up to 15%\r\nBook this hotel by 31.10.2016, for travel between 01.11.2016 and 30.04.2017. Offer applicable to all room types on any board basis.",
 "images": [
 "SOME_IMAGE_URL",
 "SOME_IMAGE_URL",
 "SOME_IMAGE_URL"
 ],
 "rating": 4,
 "facilities": [
 "24 Hour Reception",
 "Aerobics",
 "Air Conditioning"
 ]
 }
 */

@interface HotelModelMapper : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *hotelLocation;
@property (nonatomic, readonly, copy) NSString *hotelDescription;
@property (nonatomic, readonly, strong) NSArray<NSString*> *images;
@property (nonatomic, assign, readonly) NSUInteger rating;
@property (nonatomic, readonly, strong) NSArray *facilities;

@end