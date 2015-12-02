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
#import "AppDelegate.h"

@implementation Reservation

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:delegate.managedObjectContext];
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    return reservation;
}

@end
