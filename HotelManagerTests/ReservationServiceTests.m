//
//  ReservationServiceTests.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/2/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ReservationService.h"
#import "Guest.h"
#import "Reservation.h"
#import "Room.h"

@interface ReservationServiceTests : XCTestCase

@end

@implementation ReservationServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSaveReservation {
    Room *dummyRoom = [Room roomWithNumber:[NSNumber numberWithInt:1] beds:[NSNumber numberWithInt:1] rate:[NSNumber numberWithInt:1]];
    NSDate *start = [NSDate date];
    NSDate *end = [NSDate date];
    [ReservationService createReservationWithStartDate:start endDate:end room:dummyRoom firstName:@"First" lastName:@"Last" completion:^(BOOL success) {
        XCTAssertTrue(success, @"The save success must be true.");
        if (success) {
            [ReservationService deleteReservationWithRoom:dummyRoom startDate:start endDate:end completion:^(BOOL success) {
            }];
        }
    }];
}

- (void)testDeleteReservation {
    Room *dummyRoom = [Room roomWithNumber:[NSNumber numberWithInt:1] beds:[NSNumber numberWithInt:1] rate:[NSNumber numberWithInt:1]];
    NSDate *start = [NSDate date];
    NSDate *end = [NSDate date];
    [ReservationService createReservationWithStartDate:start endDate:end room:dummyRoom firstName:@"First" lastName:@"Last" completion:^(BOOL success) {
        if (success) {
            [ReservationService deleteReservationWithRoom:dummyRoom startDate:start endDate:end completion:^(BOOL success) {
                XCTAssertTrue(success, @"The deletion success must be true.");
            }];
        }
    }];
}

@end
