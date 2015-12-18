//
//  Reservation.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "Reservation.h"
#import "Guest.h"
#import "Room.h"
#import "NSObject+NSManagedObjectContext.h"

@implementation Reservation

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate totalCharge:(float)totalCharge {
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:[NSManagedObjectContext hotelManagerContext]];
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.totalCharge = totalCharge;
    return reservation;
}

@end
