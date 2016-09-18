//
//  Hotel.h
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotel : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *hotelLocation;
@property (nonatomic, readonly, copy) NSString *hotelDescription;
@property (nonatomic, readonly, strong) NSArray *images;
@property (nonatomic, assign, readonly) NSUInteger rating;
@property (nonatomic, readonly, strong) NSArray *facilities;

- (instancetype)initWithName:(NSString *)name
               hotelLocation:(NSString *)hotelLocation
            hotelDescription:(NSString *)hotelDescription
                      images:(NSArray *)images
                      rating:(NSUInteger )rating
                  facilities:(NSArray *)facilities;
@end
