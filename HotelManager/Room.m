//
//  Room.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 11/30/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "Room.h"
#import "Reservation.h"

@implementation Room

+ (instancetype)roomWithNumber:(NSNumber *)number beds:(NSNumber *)beds rate:(NSNumber *)rate {
    Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:[NSManagedObjectContext hotelManagerContext]];
    room.number = number;
    room.beds = beds;
    room.rate = rate;
    return room;
}

@end
