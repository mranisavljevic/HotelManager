//
//  Guest.h
//  HotelManager
//
//  Created by Miles Ranisavljevic on 11/30/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

@import Foundation;
@import CoreData;
#import "Reservation.h"
#import "NSObject+NSManagedObjectContext.h"

@class Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Guest : NSManagedObject

+ (instancetype)guestWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end

NS_ASSUME_NONNULL_END

#import "Guest+CoreDataProperties.h"
