//
//  AppDelegate.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 11/30/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property HomeViewController *homeVC;
@property UINavigationController *navController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setUpRootViewController];
    [self bootstrapApp];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

- (void)setUpRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.homeVC = [[HomeViewController alloc] init];
    [self.homeVC.view setBackgroundColor:[UIColor colorWithWhite:0.698 alpha:1.000]];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
}

- (void)bootstrapApp {
    NSFetchRequest *hotelFetch = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
    NSError *fetchError;
    NSInteger count = [self.managedObjectContext countForFetchRequest:hotelFetch error:&fetchError];
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
        hotels = rootObject[@"hotels"];
        for (NSDictionary *hotel in hotels) {
            Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
            newHotel.name = hotel[@"name"];
            newHotel.location = hotel[@"location"];
            newHotel.stars = hotel[@"stars"];
            
            rooms = hotel[@"rooms"];
            for (NSDictionary *room in rooms) {
                Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
                newRoom.beds = room[@"beds"];
                newRoom.number = room[@"number"];
                newRoom.rate = room[@"rate"];
                newRoom.hotel = newHotel;
            }
        }
        
        NSError *saveError;
        BOOL isSaved = [self.managedObjectContext save:&saveError];
        if (!isSaved) {
            NSLog(@"Error! Save incomplete!");
        } else {
            NSLog(@"Saved successfully!");
        }
    }
    
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HotelManager" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HotelManager.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
