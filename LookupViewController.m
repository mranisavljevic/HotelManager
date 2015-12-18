//
//  LookupViewController.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/2/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "LookupViewController.h"

@interface LookupViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSFetchedResultsController *resultsController;
@property (strong, nonatomic) NSArray *datasource;

@end

@implementation LookupViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0 alpha:1]];
    [self setUpFetchedResultsController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpFetchedResultsController {
    NSManagedObjectContext *context = [NSManagedObjectContext hotelManagerContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
    // Configure the request's entity, and optionally its predicate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    self.resultsController = [[NSFetchedResultsController alloc]
                                              initWithFetchRequest:fetchRequest
                                              managedObjectContext:context
                                              sectionNameKeyPath:nil
                                              cacheName:nil];
    
    NSError *error;
    BOOL success = [self.resultsController performFetch:&error];
    if (success) {
        NSLog(@"Successfully set up NSFetchedResultsController");
    }
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
}

@end
