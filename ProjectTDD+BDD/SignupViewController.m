//
//  SignupViewController.m
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 07.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import "SignupViewController.h"
#import "UIBarButtonItem+NavItem.h"

@implementation SignupViewController


-(void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = NSLocalizedString(@"Sign up", nil);
  
  self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonWithTitle:@"cancel" selector:@selector(dismiss) target:self];
  self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonWithTitle:@"next" selector:nil target:nil];
  [self.navigationItem.rightBarButtonItem setEnabled:NO];

}

-(void)dismiss
{
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login:(UIButton *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
