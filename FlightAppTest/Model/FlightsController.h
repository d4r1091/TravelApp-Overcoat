//
//  FlightsController.h
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightsController : NSObject

+ (void)getFlightsWithCompletionBlock:(void (^)(BOOL success, NSArray *flights, NSError *error))completionBlock;

@end
