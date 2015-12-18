//
//  ReservationService.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/2/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "ReservationService.h"

@implementation ReservationService

+ (void)createReservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room firstName:(NSString *)firstName lastName:(NSString *)lastName totalCharge:(float)totalCharge completion:(completion)completion {
    Reservation *reservation = [Reservation reservationWithStartDate:startDate endDate:endDate totalCharge:totalCharge];
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
    } else {
        completion(NO);
    }
}

+ (NSArray *)getAvailableRoomsWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSFetchRequest *existingReservationsRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
    existingReservationsRequest.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
    NSError *fetchError;
    NSArray *existingReservations = [[NSManagedObjectContext hotelManagerContext] executeFetchRequest:existingReservationsRequest error:&fetchError];
    
    NSFetchRequest *allRoomsRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
    NSError *allRoomFetchError;
    NSArray *allRooms = [[NSManagedObjectContext hotelManagerContext] executeFetchRequest:allRoomsRequest error:&allRoomFetchError];
    
    NSMutableArray *unavailableRooms = [NSMutableArray new];
    
    for (Reservation *reservation in existingReservations) {
        [unavailableRooms addObject:reservation.room];
    }
    
    NSMutableArray *availableRooms = [[NSMutableArray alloc] initWithArray:allRooms];
    
    for (Room *room in unavailableRooms) {
        [availableRooms removeObject:room];
    }
    
    NSFetchRequest *hotelRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
    NSError *hotelError;
    NSArray *hotelsArray = [[NSManagedObjectContext hotelManagerContext] executeFetchRequest:hotelRequest error:&hotelError];
    NSMutableArray *groupedAvailableRooms = [NSMutableArray arrayWithObject:hotelsArray];
    for (Hotel *hotel in hotelsArray) {
        NSMutableArray *tempArray = [NSMutableArray new];
        for (Room *room in availableRooms) {
            if ([room.hotel isEqual:hotel]) {
                [tempArray addObject:room];
            }
        }
        [groupedAvailableRooms addObject:tempArray];
    }
    NSArray *finalArray = [NSArray arrayWithArray:groupedAvailableRooms];
    return finalArray;
}

@end
