//
//  HotelModelMapper.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "HotelModelMapper.h"

@implementation HotelModelMapper

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"name",
             @"hotelLocation": @"hotel_location",
             @"hotelDescription": @"description",
             @"images": @"images",
             @"rating": @"rating",
             @"facilities": @"facilities"
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue
                             error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    return self;
}


@end
