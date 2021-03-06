//
//  FinalBookingViewController.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 12/1/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "FinalBookingViewController.h"
#import "Flurry.h"

@interface FinalBookingViewController ()

@property (strong, nonatomic) UITextField *firstNameTextField;
@property (strong, nonatomic) UITextField *lastNameTextField;

@end

@implementation FinalBookingViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.698 alpha:1.000]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFinalBookingViewController];
    [self setUpMessagesLabel];
    [self setUpTextFields];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpFinalBookingViewController {
    [self.navigationItem setTitle:NSLocalizedString(@"Confirm", nil)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)setUpMessagesLabel {
    UILabel *bookingLabel = [[UILabel alloc] init];
    bookingLabel.textAlignment = NSTextAlignmentCenter;
    bookingLabel.numberOfLines = 0;
    bookingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *startDate = [NSDateFormatter localizedStringFromDate:self.startDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    NSString *endDate = [NSDateFormatter localizedStringFromDate:self.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    bookingLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Room %@ - %@ beds - $%.2f per night. Check-in: %@ Check-out: %@", nil), self.room.number, self.room.beds, self.room.rate.floatValue, startDate, endDate];
    bookingLabel.font = [UIFont fontWithName:@"Papyrus" size:20];
    
    int nights = floorf([self.endDate timeIntervalSinceDate:self.startDate] / 60 / 60 / 24);
    float total = self.room.rate.floatValue * nights;
    
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.numberOfLines = 0;
    totalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    totalLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Total: $%.2f", nil), total];
    totalLabel.font = [UIFont fontWithName:@"Papyrus" size:30];
    
    UILabel *hotelName = [[UILabel alloc] init];
    hotelName.textAlignment = NSTextAlignmentCenter;
    hotelName.numberOfLines = 0;
    hotelName.translatesAutoresizingMaskIntoConstraints = NO;
    hotelName.text = self.room.hotel.name;
    hotelName.font = [UIFont fontWithName:@"Papyrus" size:30];
    
    NSLayoutConstraint *bookingCenterX = [NSLayoutConstraint constraintWithItem:bookingLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bookingCenterY = [NSLayoutConstraint constraintWithItem:bookingLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bookingLeading = [NSLayoutConstraint constraintWithItem:bookingLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    NSLayoutConstraint *bookingTrailing = [NSLayoutConstraint constraintWithItem:bookingLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
    
    NSLayoutConstraint *totalTop = [NSLayoutConstraint constraintWithItem:totalLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:bookingLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0];
    NSLayoutConstraint *totalTrailing = [NSLayoutConstraint constraintWithItem:totalLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:8.0];
    NSLayoutConstraint *totalLeading = [NSLayoutConstraint constraintWithItem:totalLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:8.0];
    
    NSLayoutConstraint *hotelNameCenterX = [NSLayoutConstraint constraintWithItem:hotelName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *hotelNameBottom = [NSLayoutConstraint constraintWithItem:hotelName attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bookingLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:8.0];
    
    [self.view addSubview:bookingLabel];
    [self.view addSubview:totalLabel];
    [self.view addSubview:hotelName];
    
    bookingCenterX.active = YES;
    bookingCenterY.active = YES;
    bookingLeading.active = YES;
    bookingTrailing.active = YES;
    
    totalTop.active = YES;
    totalTrailing.active = YES;
    totalLeading.active = YES;
    
    hotelNameCenterX.active = YES;
    hotelNameBottom.active = YES;
}

- (void)setUpTextFields {
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    self.firstNameTextField = [[UITextField alloc] init];
    self.lastNameTextField = [[UITextField alloc] init];
    
    self.firstNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.lastNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.firstNameTextField.font = [UIFont fontWithName:@"Papyrus" size:20];
    self.lastNameTextField.font =[UIFont fontWithName:@"Papyrus" size:20];
    
    self.firstNameTextField.layer.cornerRadius = 5.0;
    self.lastNameTextField.layer.cornerRadius = 5.0;
    
    self.firstNameTextField.placeholder = NSLocalizedString(@" First Name", nil);
    self.lastNameTextField.placeholder = NSLocalizedString(@" Last Name", nil);
    
    self.firstNameTextField.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
    self.lastNameTextField.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
    
    NSLayoutConstraint *firstNameTop = [NSLayoutConstraint constraintWithItem:self.firstNameTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:navBarHeight + 40.0];
    NSLayoutConstraint *firstNameLeading = [NSLayoutConstraint constraintWithItem:self.firstNameTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0.0];
    NSLayoutConstraint *firstNameTrailing = [NSLayoutConstraint constraintWithItem:self.firstNameTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *lastNameTop = [NSLayoutConstraint constraintWithItem:self.lastNameTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.firstNameTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8.0];
    NSLayoutConstraint *lastNameLeading = [NSLayoutConstraint constraintWithItem:self.lastNameTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0.0];
    NSLayoutConstraint *lastNameTrailing = [NSLayoutConstraint constraintWithItem:self.lastNameTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0.0];
    
    [self.view addSubview:self.firstNameTextField];
    [self.view addSubview:self.lastNameTextField];
    
    firstNameTop.active = YES;
    firstNameTrailing.active = YES;
    firstNameLeading.active = YES;
    
    lastNameTop.active = YES;
    lastNameTrailing.active = YES;
    lastNameLeading.active = YES;
    
    [self.firstNameTextField becomeFirstResponder];
}

- (void)saveButtonSelected:(UIBarButtonItem *)sender {
    if (self.firstNameTextField.text.length > 0 && self.lastNameTextField.text.length > 0) {
        int nights = floorf([self.endDate timeIntervalSinceDate:self.startDate] / 60 / 60 / 24);
        float total = self.room.rate.floatValue * nights;
        [ReservationService createReservationWithStartDate:self.startDate endDate:self.endDate room:self.room firstName:self.firstNameTextField.text lastName:self.lastNameTextField.text totalCharge:total completion:^(BOOL success) {
            if (success) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"What!?!", nil) message:NSLocalizedString(@"Put your names in there!", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        [Flurry logEvent:@"User tried to reserve without entering name."];
    }
}

@end
