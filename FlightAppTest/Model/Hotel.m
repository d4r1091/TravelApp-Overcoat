//
//  Hotel.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "Hotel.h"

@implementation Hotel


- (instancetype)initWithName:(NSString *)name
               hotelLocation:(NSString *)hotelLocation
            hotelDescription:(NSString *)hotelDescription
                      images:(NSArray *)images
                      rating:(NSUInteger )rating
                  facilities:(NSArray *)facilities {
    self = [super init];
    if (self) {
        _name = name;
        _hotelLocation = hotelLocation;
        _hotelDescription = hotelDescription;
        _images = images;
        _rating = rating;
        _facilities = facilities;
    }
    return self;
}
@end
