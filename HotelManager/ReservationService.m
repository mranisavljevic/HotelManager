//
//  ReservationService.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/2/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "ReservationService.h"

@implementation ReservationService

+ (void)createReservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room firstName:(NSString *)firstName lastName:(NSString *)lastName completion:(completion)completion {
    Reservation *reservation = [Reservation reservationWithStartDate:startDate endDate:endDate];
    Guest *guest = [Guest guestWithFirstName:firstName lastName:lastName];
    reservation.guest = guest;
    reservation.room = room;
    room.reservation = reservation;
    
    NSError *saveError;
    
    [[NSManagedObjectContext hotelManagerContext] save:&saveError];
    
    if (!saveError) {
        completion(YES);
    }
}

+ (void)deleteReservationWithRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate completion:(completion)completion {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    NSManagedObjectContext *context = [NSManagedObjectContext hotelManagerContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"room = %@ AND startDate = %@ AND endDate = %@", room, startDate, endDate];
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    if (!error) {
        if (results.count == 1) {
            Reservation *fetchedReservation = (Reservation *)results.firstObject;
            [context deleteObject:fetchedReservation];
            NSError *deleteError;
            [context save:&deleteError];
            if (!error) {
                completion(YES);
            }
        }
    }
    completion(NO);
}

@end
