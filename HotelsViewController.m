//
//  HotelsViewController.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 11/30/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "HotelsViewController.h"

@interface HotelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HotelsViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.698 alpha:1.000]];
    [self setUpHotelsViewController];
    [self setUpTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*)datasource {
    if (!_datasource) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.managedObjectContext;
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        NSError *fetchError;
        _datasource = [context executeFetchRequest:request error:&fetchError];
        if (fetchError) {
            NSLog(@"%@", fetchError.userInfo);
        }
    }
    return _datasource;
}

- (void)setUpHotelsViewController {
    self.datasource = [self datasource];
    NSDictionary *titleAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"Papyrus" size:20]};
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    [self.navigationItem setTitle:@"Hotels"];
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

#pragma mark - UITableViewDelegate, UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Hotel *hotel = self.datasource[indexPath.row];
    cell.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    cell.layer.cornerRadius = 5.0;
    [cell.textLabel setFont:[UIFont fontWithName:@"Papyrus" size:20]];
    cell.textLabel.text = hotel.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImage *hotelImage = [UIImage imageNamed:@"badHotel.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:hotelImage];
    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 150);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setClipsToBounds:YES];
    return imageView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomsViewController *roomsVC = [[RoomsViewController alloc] init];
    Hotel *hotel = self.datasource[indexPath.row];
    roomsVC.hotel = hotel;
    [self.navigationController pushViewController:roomsVC animated:YES];
}

@end
