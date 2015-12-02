//
//  Guest.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 11/30/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "Guest.h"

@implementation Guest

+ (instancetype)guestWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[NSManagedObjectContext hotelManagerContext]];
    guest.firstName = firstName;
    guest.lastName = lastName;
    return guest;
}

@end
