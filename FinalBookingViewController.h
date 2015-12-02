//
//  FinalBookingViewController.h
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

@import UIKit;
#import "AppDelegate.h"
#import "Room.h"
#import "Reservation.h"

@interface FinalBookingViewController : UIViewController

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) Room *room;

@end
