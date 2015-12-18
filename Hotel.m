//
//  Hotel.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "Hotel.h"
#import "Room.h"
#import "NSObject+NSManagedObjectContext.h"

@implementation Hotel

+ (instancetype)hotelWithName:(NSString *)name location:(NSString *)location stars:(NSNumber *)stars {
    Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:[NSManagedObjectContext hotelManagerContext]];
    hotel.name = name;
    hotel.location = location;
    hotel.stars = stars;
    return hotel;
}

@end
