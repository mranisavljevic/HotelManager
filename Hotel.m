//
//  Hotel.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "Hotel.h"
#import "Room.h"
#import "AppDelegate.h"

@implementation Hotel

+ (instancetype)hotelWithName:(NSString *)name location:(NSString *)location stars:(NSNumber *)stars {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:delegate.managedObjectContext];
    hotel.name = name;
    hotel.location = location;
    hotel.stars = stars;
    return hotel;
}

@end
