//
//  BookViewController.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()

@property UIDatePicker *startDatePicker;
@property UIDatePicker *endDatePicker;

@end

@implementation BookViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.875 alpha:1.000]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBookViewController];
    [self setUpDatePickers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpBookViewController {
    [self.navigationItem setTitle:NSLocalizedString(@"Book Dates", nil)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)setUpDatePickers {
    self.startDatePicker = [[UIDatePicker alloc] init];
    self.endDatePicker = [[UIDatePicker alloc] init];
    
    self.startDatePicker.translatesAutoresizingMaskIntoConstraints = NO;
    self.endDatePicker.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.startDatePicker.datePickerMode = UIDatePickerModeDate;
    self.endDatePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.startDatePicker addTarget:self action:@selector(startPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.startDatePicker.minimumDate = [NSDate date];
    self.endDatePicker.minimumDate = [NSDate dateWithTimeInterval:86400 sinceDate:self.startDatePicker.date];
    
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    float halfAvailableViewHeight = (self.view.frame.size.height - navBarHeight - 40.0) / 2;
    
    NSLayoutConstraint *startTop = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:navBarHeight + 40.0];
    NSLayoutConstraint *startLeading = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0.0];
    NSLayoutConstraint *startTrailing = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0.0];
    NSLayoutConstraint *startHeight = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:halfAvailableViewHeight];
    
    NSLayoutConstraint *endTop = [NSLayoutConstraint constraintWithItem:self.endDatePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.startDatePicker attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *endLeading = [NSLayoutConstraint constraintWithItem:self.endDatePicker attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0.0];
    NSLayoutConstraint *endTrailing = [NSLayoutConstraint constraintWithItem:self.endDatePicker attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0.0];
    NSLayoutConstraint *endHeight = [NSLayoutConstraint constraintWithItem:self.endDatePicker attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:halfAvailableViewHeight];
    
    [self.view addSubview:self.startDatePicker];
    [self.view addSubview:self.endDatePicker];
    
    startTop.active = YES;
    startTrailing.active = YES;
    startHeight.active = YES;
    startLeading.active = YES;
    
    endTop.active = YES;
    endTrailing.active = YES;
    endHeight.active = YES;
    endLeading.active = YES;
    
    
    
    UILabel *startLabel = [[UILabel alloc] init];
    UILabel *endLabel = [[UILabel alloc] init];
    
    startLabel.text = NSLocalizedString(@"Check In:", nil);
    endLabel.text = NSLocalizedString(@"Check Out:", nil);
    
    startLabel.textColor = [UIColor blackColor];
    endLabel.textColor = [UIColor blackColor];
    
    startLabel.font = [UIFont fontWithName:@"Papyrus" size:30];
    endLabel.font = [UIFont fontWithName:@"Papyrus" size:30];
    
    startLabel.translatesAutoresizingMaskIntoConstraints = NO;
    endLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *startLabelTop = [NSLayoutConstraint constraintWithItem:startLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.startDatePicker attribute:NSLayoutAttributeTop multiplier:1.0 constant:50.0];
    NSLayoutConstraint *startLabelCenterX = [NSLayoutConstraint constraintWithItem:startLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.startDatePicker attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *endLabelTop = [NSLayoutConstraint constraintWithItem:endLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.endDatePicker attribute:NSLayoutAttributeTop multiplier:1.0 constant:50.0];
    NSLayoutConstraint *endLabelCenterX = [NSLayoutConstraint constraintWithItem:endLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.endDatePicker attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    [self.view addSubview:startLabel];
    [self.view addSubview:endLabel];
    
    startLabelTop.active = YES;
    startLabelCenterX.active = YES;
    
    endLabelTop.active = YES;
    endLabelCenterX.active = YES;
    
}

- (void)startPickerValueChanged:(UIDatePicker *)sender {
    if (self.endDatePicker.date <= self.startDatePicker.date || floorf([self.endDatePicker.date timeIntervalSinceDate:self.startDatePicker.date] / 60 / 60 / 24) > 30) {
        [self.endDatePicker setDate:[NSDate dateWithTimeInterval:86400 sinceDate:self.startDatePicker.date] animated:YES];
    }
}

- (void)doneButtonPressed:(UIBarButtonItem *)sender {
    NSDate *startDate = self.startDatePicker.date;
    NSDate *endDate = self.endDatePicker.date;
    if (startDate >= endDate) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"What!?!", nil) message:NSLocalizedString(@"You can't book a stay for negative days!", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.endDatePicker setDate:[NSDate dateWithTimeInterval:86400 sinceDate:startDate] animated:YES];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        AvailabilityViewController *availabilityVC = [[AvailabilityViewController alloc] init];
        availabilityVC.startDate = startDate;
        availabilityVC.endDate = endDate;
        [self.navigationController pushViewController:availabilityVC animated:YES];
    }
}

@end
