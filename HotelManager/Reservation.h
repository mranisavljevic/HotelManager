//
//  Reservation.h
//  HotelManager
//
//  Created by Miles Ranisavljevic on 11/30/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

@import Foundation;
@import CoreData;
#import "NSObject+NSManagedObjectContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface Reservation : NSManagedObject

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end

NS_ASSUME_NONNULL_END

#import "Reservation+CoreDataProperties.h"
