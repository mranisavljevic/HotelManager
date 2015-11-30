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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpView {
    [self.navigationItem setTitle:@"Hotel Manager"];
}

@end
