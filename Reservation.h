//
//  Reservation.h
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

NS_ASSUME_NONNULL_BEGIN

@interface Reservation : NSManagedObject

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate totalCharge:(float)totalCharge;

@end

NS_ASSUME_NONNULL_END

#import "Reservation+CoreDataProperties.h"
