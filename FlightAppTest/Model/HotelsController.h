//
//  HotelsController.h
//  FlightAppTest
//
//  Created by Dario Carlomagno on 13/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Hotel;
@interface HotelsController : NSObject

+ (void)getHotelsWithCompletionBlock:(void (^)(BOOL, Hotel *, NSError *))completionBlock;

+ (void)getHotelImageWithUrlString:(NSString *)urlString completionBlock:(void (^)(BOOL, UIImage*, NSError *))completion;

@end
