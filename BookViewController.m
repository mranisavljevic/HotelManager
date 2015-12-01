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
    [self.view setBackgroundColor:[UIColor colorWithRed:0.333 green:0.329 blue:0.329 alpha:1.000]];
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
    [self.navigationItem setTitle:@"Book a Room"];
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
    
    self.startDatePicker.minimumDate = [NSDate date];
    self.endDatePicker.minimumDate = [NSDate dateWithTimeInterval:86400 sinceDate:self.startDatePicker.date];
    
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    float halfAvailableViewHeight = (self.view.frame.size.height - navBarHeight - 40.0) / 2;
    
    NSLayoutConstraint *startTop = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:navBarHeight + 20.0];
    NSLayoutConstraint *startLeading = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0.0];
    NSLayoutConstraint *startTrailing = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0.0];
    NSLayoutConstraint *startHeight = [NSLayoutConstraint constraintWithItem:self.startDatePicker attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:halfAvailableViewHeight];
    
    NSLayoutConstraint *endTop = [NSLayoutConstraint constraintWithItem:self.endDatePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.startDatePicker attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0];
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
    
    startLabel.text = @"Check In:";
    endLabel.text = @"Check Out:";
    
    startLabel.textColor = [UIColor whiteColor];
    endLabel.textColor = [UIColor whiteColor];
    
    startLabel.font = [UIFont fontWithName:@"Papyrus" size:20];
    endLabel.font = [UIFont fontWithName:@"Papyrus" size:20];
    
    startLabel.translatesAutoresizingMaskIntoConstraints = NO;
    endLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *startLabelTop = [NSLayoutConstraint constraintWithItem:startLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.startDatePicker attribute:NSLayoutAttributeTop multiplier:1.0 constant:40.0];
    NSLayoutConstraint *startLabelCenterX = [NSLayoutConstraint constraintWithItem:startLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.startDatePicker attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *endLabelTop = [NSLayoutConstraint constraintWithItem:endLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.endDatePicker attribute:NSLayoutAttributeTop multiplier:1.0 constant:40.0];
    NSLayoutConstraint *endLabelCenterX = [NSLayoutConstraint constraintWithItem:endLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.endDatePicker attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    [self.view addSubview:startLabel];
    [self.view addSubview:endLabel];
    
    startLabelTop.active = YES;
    startLabelCenterX.active = YES;
    
    endLabelTop.active = YES;
    endLabelCenterX.active = YES;
    
}

- (void)doneButtonPressed:(UIBarButtonItem *)sender {
    
}

@end
