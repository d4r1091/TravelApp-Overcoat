//
//  Utils.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 18/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "Utils.h"
#import <UIKit/UIKit.h>

@implementation Utils

+ (void)showAlertOnViewController:(UIViewController *)viewController withMessage:(NSString *)message {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:appName
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *closeAlert = [UIAlertAction actionWithTitle:@"ok"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
    
    [alert addAction:closeAlert];
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
