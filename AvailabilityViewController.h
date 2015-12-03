//
//  AvailabilityViewController.h
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

@import UIKit;
#import "AppDelegate.h"
#import "Reservation.h"
#import "Room.h"
#import "Hotel.h"
#import "FinalBookingViewController.h"
#import "NSObject+NSManagedObjectContext.h"
#import "ReservationService.h"

@interface AvailabilityViewController : UIViewController

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end
