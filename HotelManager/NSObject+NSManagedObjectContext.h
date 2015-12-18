//
//  NSObject+NSManagedObjectContext.h
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

@import Foundation;
@import CoreData;
#import "AppDelegate.h"

@interface NSObject (NSManagedObjectContext)

+ (NSManagedObjectContext *)hotelManagerContext;

@end
