//
//  Reservation+CoreDataProperties.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 11/30/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Reservation+CoreDataProperties.h"

@implementation Reservation (CoreDataProperties)

@dynamic startDate;
@dynamic endDate;
@dynamic room;
@dynamic guest;

@end