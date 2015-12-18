//
//  LookupViewController.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/2/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "LookupViewController.h"

@interface LookupViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSFetchedResultsController *resultsController;

@end

@implementation LookupViewController

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = NSLocalizedString(@"Search Reservations", nil);
        
        UIView *barView = _searchBar.subviews.firstObject;
        UITextField *textField = (UITextField *)[[barView subviews] objectAtIndex:1];
        
        textField.font = [UIFont fontWithName:@"Papyrus" size:15];
        _searchBar.delegate = self;
        
    }
    
    return _searchBar;
}

- (NSFetchedResultsController *) resultsController {
    if (!_resultsController) {
        
        NSManagedObjectContext *context = [NSManagedObjectContext hotelManagerContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
        fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES]];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"guest.firstName == %@", nil];
        
        _resultsController = [[NSFetchedResultsController alloc]initWithFetchRequest: fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        _resultsController.delegate = self;
        
        [_resultsController performFetch:nil];
    }
    
    return _resultsController;
}

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0 alpha:1]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBar];
    [self setUpTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpSearchBar {
    UISearchBar *searchBar = self.searchBar;
    [searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:searchBar];
    
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    NSLayoutConstraint *searchBarTop = [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:navBarHeight + 20.0];
    NSLayoutConstraint *searchBarLeading = [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *searchBarTrailing = [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *searchBarHeight = [NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44.0];
    
    searchBarTop.active = YES;
    searchBarTrailing.active = YES;
    searchBarLeading.active = YES;
    searchBarHeight.active = YES;
    
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:0.875 alpha:1.000]];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLayoutConstraint *tableViewTop = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.searchBar attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *tableViewLeading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *tableViewTrailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *tableViewBottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    tableViewTop.active = YES;
    tableViewLeading.active = YES;
    tableViewTrailing.active = YES;
    tableViewBottom.active = YES;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([[self.resultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.resultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell = [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    cell.layer.cornerRadius = 5.0;
    [cell.textLabel setFont:[UIFont fontWithName:@"Papyrus" size:20]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Papyrus" size:12]];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    Reservation *reservation = [self.resultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", reservation.guest.firstName, reservation.guest.lastName];
    [cell.detailTextLabel setText:[NSString stringWithFormat:NSLocalizedString(@"%@, room %@ - $%.2f due.", nil), reservation.room.hotel.name, reservation.room.number, reservation.totalCharge]];
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSUInteger resultCount = [[self.resultsController.sections objectAtIndex:0] numberOfObjects];
    if (searchText.length == 0) {
        self.resultsController.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"guest.firstName == %@", nil];
    } else {
        NSString *searchString = [[@"*" stringByAppendingString:searchText] stringByAppendingString:@"*"];
        self.resultsController.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"guest.firstName LIKE[cd] %@ OR guest.lastName LIKE[cd] %@",searchString, searchString];
    }
    
    
    [self.resultsController performFetch:nil];
    NSUInteger updatedResultCount = [[self.resultsController.sections objectAtIndex:0] numberOfObjects];
    if (!(resultCount == updatedResultCount)) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        default: break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
//                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
