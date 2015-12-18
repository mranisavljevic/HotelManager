//
//  Room.h
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Room : NSManagedObject

+ (instancetype)roomWithNumber:(NSNumber *)number beds:(NSNumber *)beds rate:(NSNumber *)rate;

@end

NS_ASSUME_NONNULL_END

#import "Room+CoreDataProperties.h"
