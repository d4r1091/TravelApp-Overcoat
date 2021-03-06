//
//  APIClient.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "APIClient.h"
#import "Constants.h"
#import "FlightModelMapper.h"
#import "HotelModelMapper.h"

@implementation APIClient

+ (id)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (void)getFlightsWithCompletionBlock:(void (^)(BOOL, NSArray *, NSError *))completionBlock {
    [self GET:FlightsEndPoint parameters:nil
   completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
       NSArray *flights = ((FlightsModelMapper *)response.result).flights;
       completionBlock(error==nil, flights, error);
   }];
}

- (void)getHotelsWithCompletionBlock:(void (^)(BOOL, HotelModelMapper *, NSError *))completionBlock {
    [self GET:HotelsEndPoint parameters:nil completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
        HotelModelMapper *hotel = response.result;
        completionBlock(error==nil, hotel, error);
    }];    
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             FlightsEndPoint: [FlightsModelMapper class],
             HotelsEndPoint: [HotelModelMapper class]
             };
}

@end
