//
//  Utils.h
//  FlightAppTest
//
//  Created by Dario Carlomagno on 18/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@interface Utils : NSObject

+ (void)showAlertOnViewController:(UIViewController *)viewController withMessage:(NSString *)message;

@end
