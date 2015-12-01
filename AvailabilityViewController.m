//
//  AvailabilityViewController.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "AvailabilityViewController.h"

@interface AvailabilityViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) NSArray *hotels;

@end

@implementation AvailabilityViewController

- (NSArray *)datasource {
    if (!_datasource) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSFetchRequest *existingReservationsRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
        existingReservationsRequest.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.endDate, self.startDate];
        NSError *fetchError;
        NSArray *existingReservations = [delegate.managedObjectContext executeFetchRequest:existingReservationsRequest error:&fetchError];
        
        NSFetchRequest *allRoomsRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
        NSError *allRoomFetchError;
        NSArray *allRooms = [delegate.managedObjectContext executeFetchRequest:allRoomsRequest error:&allRoomFetchError];
        
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
        NSArray *hotels = [delegate.managedObjectContext executeFetchRequest:hotelRequest error:&hotelError];
        self.hotels = hotels;
        NSMutableArray *groupedAvailableRooms = [NSMutableArray new];
        for (Hotel *hotel in self.hotels) {
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
    return _datasource;
}

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.875 alpha:1.000]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self setUpAvailabilityViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:0.875 alpha:1.000]];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLayoutConstraint *tableViewTop = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *tableViewLeading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *tableViewTrailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *tableViewBottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    tableViewTop.active = YES;
    tableViewLeading.active = YES;
    tableViewTrailing.active = YES;
    tableViewBottom.active = YES;
}

- (void)setUpAvailabilityViewController {
    self.datasource = [self datasource];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datasource.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Hotel *hotel = self.hotels[section];
    return hotel.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *source = (NSArray *)self.datasource[section];
    return source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    cell.layer.cornerRadius = 5.0;
    [cell.textLabel setFont:[UIFont fontWithName:@"Papyrus" size:20]];
    cell.textLabel.text = @"test";
    return cell;
}

@end
