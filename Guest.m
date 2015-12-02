//
//  Guest.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#import "AppDelegate.h"

@implementation Guest

+ (instancetype)guestWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:delegate.managedObjectContext];
    guest.firstName = firstName;
    guest.lastName = lastName;
    return guest;
}

@end
