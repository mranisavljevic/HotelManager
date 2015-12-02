//
//  Room.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "Room.h"
#import "Hotel.h"
#import "Reservation.h"
#import "NSObject+NSManagedObjectContext.h"

@implementation Room

+ (instancetype)roomWithNumber:(NSNumber *)number beds:(NSNumber *)beds rate:(NSNumber *)rate {
    Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:[NSManagedObjectContext hotelManagerContext]];
    room.number = number;
    room.beds = beds;
    room.rate = rate;
    return room;
}

@end
