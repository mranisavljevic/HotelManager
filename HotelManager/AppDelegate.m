//
//  AppDelegate.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 11/30/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataStack.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "Flurry.h"

@interface AppDelegate ()

@property HomeViewController *homeVC;
@property UINavigationController *navController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class]]];
    [Flurry startSession:@"RX329M79VYW29BDZ9PZJ"];
    [self setUpRootViewController];
    [self bootstrapApp];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    CoreDataStack *shared = [CoreDataStack sharedStack];
    [shared saveContext];
}

- (void)setUpRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.homeVC = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    [self.homeVC.view setBackgroundColor:[UIColor colorWithWhite:0.698 alpha:1.000]];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
}

- (void)bootstrapApp {
    NSFetchRequest *hotelFetch = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
    NSError *fetchError;
    NSInteger count = [[CoreDataStack sharedStack].managedObjectContext countForFetchRequest:hotelFetch error:&fetchError];
    if (count == 0) {
        NSDictionary *hotels = [NSDictionary new];
        NSDictionary *rooms = [NSDictionary new];
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"hotels" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        
        NSError *jsonError;
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
        if (jsonError) {
            NSLog(@"Error serializing JSON object.");
            return;
        }
        hotels = rootObject[@"Hotels"];
        for (NSDictionary *hotel in hotels) {
            Hotel *newHotel = [Hotel hotelWithName:hotel[@"name"] location:hotel[@"location"] stars:hotel[@"stars"]];
//            Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
//            newHotel.name = hotel[@"name"];
//            newHotel.location = hotel[@"location"];
//            newHotel.stars = hotel[@"stars"];
            
            rooms = hotel[@"rooms"];
            for (NSDictionary *room in rooms) {
                Room *newRoom = [Room roomWithNumber:room[@"number"] beds:room[@"beds"] rate:room[@"rate"]];
//                Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
//                newRoom.beds = room[@"beds"];
//                newRoom.number = room[@"number"];
//                newRoom.rate = room[@"rate"];
                newRoom.hotel = newHotel;
            }
        }
        
        NSError *saveError;
        BOOL isSaved = [[CoreDataStack sharedStack].managedObjectContext save:&saveError];
        if (!isSaved) {
            NSLog(@"Error! Save incomplete!");
        } else {
            NSLog(@"Saved successfully!");
        }
    }
}

@end
