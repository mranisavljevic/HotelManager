//
//  NSObject+NSManagedObjectContext.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "NSObject+NSManagedObjectContext.h"
#import "CoreDataStack.h"

@implementation NSObject (NSManagedObjectContext)

+ (NSManagedObjectContext*)hotelManagerContext {
    return [CoreDataStack sharedStack].managedObjectContext;
}

@end
