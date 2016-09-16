//
//  FlightsTableViewCell.m
//  FlightAppTest
//
//  Created by Dario Carlomagno on 12/09/16.
//  Copyright © 2016 OnTheBeach. All rights reserved.
//

#import "FlightsTableViewCell.h"

@interface FlightsTableViewCell() {
    CGFloat _shadowWidth;
}

@property (weak, nonatomic) IBOutlet UILabel *arrivalAirport;
@property (weak, nonatomic) IBOutlet UILabel *airline;
@property (weak, nonatomic) IBOutlet UILabel *departureAirport;
@property (weak, nonatomic) IBOutlet UILabel *arrivalDate;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *departureDate;

- (IBAction)closeClicked:(id)sender;

@end

@implementation FlightsTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    if (_shadowWidth != bounds.size.width)
    {
        if (_shadowWidth == 0)
        {
            [self.layer setMasksToBounds:NO ];
            [self.layer setShadowColor:[[UIColor blackColor ] CGColor ] ];
            [self.layer setShadowOpacity:0.5 ];
            [self.layer setShadowRadius:5.0 ];
            [self.layer setShadowOffset:CGSizeMake( 0 , 0 ) ];
            self.layer.cornerRadius = 5.0;
        }
        [self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:bounds ] CGPath ] ];
        _shadowWidth = bounds.size.width;
    }
}

- (void)flipTransitionWithOptions:(UIViewAnimationOptions)options halfway:(void (^)(BOOL finished))halfway completion:(void (^)(BOOL finished))completion
{
    CGFloat degree = (options & UIViewAnimationOptionTransitionFlipFromRight) ? -M_PI_2 : M_PI_2;
    
    CGFloat duration = 0.4;
    CGFloat distanceZ = 2000;
    CGFloat translationZ = self.frame.size.width / 2;
    CGFloat scaleXY = (distanceZ - translationZ) / distanceZ;
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -distanceZ; // perspective
    rotationAndPerspectiveTransform = CATransform3DTranslate(rotationAndPerspectiveTransform, 0, 0, translationZ);
    
    rotationAndPerspectiveTransform = CATransform3DScale(rotationAndPerspectiveTransform, scaleXY, scaleXY, 1.0);
    self.layer.transform = rotationAndPerspectiveTransform;
    
    [UIView animateWithDuration:duration / 2 animations:^{
        self.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, degree, 0.0f, 1.0f, 0.0f);
    } completion:^(BOOL finished){
        if (halfway) halfway(finished);
        self.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -degree, 0.0f, 1.0f, 0.0f);
        [UIView animateWithDuration:duration / 2 animations:^{
            self.layer.transform = rotationAndPerspectiveTransform;
        } completion:^(BOOL finished){
            self.layer.transform = CATransform3DIdentity;
            if (completion) completion(finished);
        }];
    }];
}

- (void)bindDataWithAirlane:(NSString *)airlane departureDate:(NSDate *)departure arrival:(NSDate *)arrival price:(NSUInteger )price departureAirport:(NSString *)departureAirport arrivalAirport:(NSString *)arrivalAirport {
    _airline.text = airlane;
    _departureDate.text = [self stringFromTargetDate:departure];
    _arrivalDate.text = [self stringFromTargetDate:arrival];;
    _price.text = [NSString stringWithFormat:@"₤ %@",  @(price)];  ;
    _departureAirport.text = departureAirport;
    _arrivalAirport.text = arrivalAirport;
}

- (NSString *)stringFromTargetDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"M/d/yy 'at' h:mma"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

#pragma mark - UITableViewCell Actions

- (void)closeClicked:(id)sender {
    if (_delegate) {
        // if you want to add some actions ViewController side
        [_delegate userDidClickedCloseButton:self];
    }
    [self flipTransitionWithOptions:UIViewAnimationOptionTransitionFlipFromRight halfway:^(BOOL finished) {
        // some stuffs
    } completion:nil];
}

@end
