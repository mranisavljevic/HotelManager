//
//  Hotel.h
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room;

NS_ASSUME_NONNULL_BEGIN

@interface Hotel : NSManagedObject

+ (instancetype)hotelWithName:(NSString *)name location:(NSString *)location stars:(NSNumber *)stars;

@end

NS_ASSUME_NONNULL_END

#import "Hotel+CoreDataProperties.h"
