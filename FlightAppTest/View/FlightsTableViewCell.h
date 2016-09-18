//
//  FlightsTableViewCell.h
//  FlightAppTest
//
//  Created by Dario Carlomagno on 12/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlightsTableViewCell;
@protocol FlightsTableViewCellProtocol <NSObject>

- (void)userDidClickedCloseButton:(FlightsTableViewCell *)cell;

@end

@interface FlightsTableViewCell : UICollectionViewCell

@property (nonatomic, strong) id<FlightsTableViewCellProtocol> delegate;

- (void)bindDataWithAirlane:(NSString *) airlane
              departureDate:(NSDate *)departure
                    arrival:(NSDate *)arrival
                      price:(NSUInteger)price
           departureAirport:(NSString *)departureAirport
             arrivalAirport:(NSString *)arrivalAirport;

@end
