//
//  ReservationService.h
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/2/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

@import UIKit;
#import "NSObject+NSManagedObjectContext.h"
#import "Reservation.h"
#import "Guest.h"

typedef void(^completion)(BOOL success);

@interface ReservationService : NSObject

+ (void)createReservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room firstName:(NSString *)firstName lastName:(NSString *)lastName totalCharge:(float)totalCharge completion:(completion)completion;
+ (void)deleteReservationWithRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate completion:(completion)completion;
+ (NSArray *)getAvailableRoomsWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
