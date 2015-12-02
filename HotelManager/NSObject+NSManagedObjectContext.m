//
//  NSObject+NSManagedObjectContext.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "NSObject+NSManagedObjectContext.h"

@implementation NSObject (NSManagedObjectContext)

+ (NSManagedObjectContext*)hotelManagerContext {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    return delegate.managedObjectContext;
}

@end
