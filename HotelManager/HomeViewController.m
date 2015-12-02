//
//  HomeViewController.m
//  HotelManager
//
//  Created by Miles Ranisavljevic on 11/30/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)loadView {
    [super loadView];
    [self setUpView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCustomLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpView {
    NSDictionary *titleAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"Papyrus" size:20]};
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
    [self.navigationItem setTitle:@"Hotel Manager"];
}

- (void)setUpCustomLayout {
    float navBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    UIButton *browseButton = [[UIButton alloc] init];
    UIButton *bookButton = [[UIButton alloc] init];
    UIButton *lookupButton = [[UIButton alloc] init];
    
    [browseButton setBackgroundColor:[UIColor colorWithWhite:0.875 alpha:1.000]];
    [bookButton setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [lookupButton setBackgroundColor:[UIColor colorWithWhite:0.529 alpha:1.000]];
    
    [browseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bookButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lookupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [browseButton setTitle:@"Browse Hotels" forState:UIControlStateNormal];
    [bookButton setTitle:@"Book Hotels" forState:UIControlStateNormal];
    [lookupButton setTitle:@"Look Up Reservation" forState:UIControlStateNormal];
    
    [[browseButton titleLabel] setFont:[UIFont fontWithName:@"Papyrus" size:24]];
    [[bookButton titleLabel] setFont:[UIFont fontWithName:@"Papyrus" size:24]];
    [[lookupButton titleLabel] setFont:[UIFont fontWithName:@"Papyrus" size:24]];
    
    [browseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bookButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [lookupButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *browseButtonTop = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:44.0];
    NSLayoutConstraint *browseButtonLeading = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *browseButtonTrailing = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *browseButtonHeight = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:floorf((self.view.frame.size.height - navBarHeight) / 3.0)];
    
    NSLayoutConstraint *bookButtonTop = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:browseButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bookButtonLeading = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bookButtonTrailing = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bookButtonHeight = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:floorf((self.view.frame.size.height - navBarHeight) / 3.0)];
    
    NSLayoutConstraint *lookupButtonTop = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:bookButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *lookupButtonLeading = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *lookupButtonTrailing = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    NSLayoutConstraint *lookupButtonHeight = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:floorf((self.view.frame.size.height - navBarHeight) / 3.0)];
    
    [self.view addSubview:browseButton];
    [self.view addSubview:bookButton];
    [self.view addSubview:lookupButton];
    
    browseButtonTop.active = YES;
    browseButtonLeading.active = YES;
    browseButtonTrailing.active = YES;
    browseButtonHeight.active = YES;
    
    bookButtonTop.active = YES;
    bookButtonLeading.active = YES;
    bookButtonTrailing.active = YES;
    bookButtonHeight.active = YES;
    
    lookupButtonTop.active = YES;
    lookupButtonLeading.active = YES;
    lookupButtonTrailing.active = YES;
    lookupButtonHeight.active = YES;
    
    [browseButton addTarget:self action:@selector(browseButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [bookButton addTarget:self action:@selector(bookButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [lookupButton addTarget:self action:@selector(lookupButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)browseButtonPressed {
    HotelsViewController *hotelsVC = [[HotelsViewController alloc] init];
    [self.navigationController pushViewController:hotelsVC animated:YES];
}

- (void)bookButtonPressed {
    BookViewController *bookVC = [[BookViewController alloc] init];
    [self.navigationController pushViewController:bookVC animated:YES];
}

- (void)lookupButtonPressed {
    
}

@end
