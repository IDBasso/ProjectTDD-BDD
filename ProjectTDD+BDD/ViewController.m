//
//  ViewController.m
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 06.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+BackgroundColor.h"
#import "NSString+Email.h"
#import "UIBarButtonItem+NavItem.h"
#import "SignupViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController
{
  UIBarButtonItem *_loginButton;
}

#pragma mark - life cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = NSLocalizedString(@"Hello World", nil);
  self.usernameTextField.delegate = self;
  self.passwordTexField.delegate = self;
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
  
  [self setupLoginButton];
  
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UITextFieldTextDidChangeNotification
                                                object:nil];
}

#pragma mark - login button
-(void)setupLoginButton
{
  _loginButton = [UIBarButtonItem buttonWithTitle:@"login" selector:nil target:self];
  self.navigationItem.rightBarButtonItem = _loginButton;
  [self updateLoginButton];
}

-(void)updateLoginButton
{
  //TODO: Check if user name and password are filled in
  BOOL userDataIsFilledIn = (self.usernameTextField.text.length >= 1) && [self.usernameTextField.text isValidEmail] && (self.passwordTexField.text.length >= 1);
  [_loginButton setEnabled:userDataIsFilledIn];
}

#pragma mark - textfield delegate methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSUInteger newLength = [textField.text length] + [string length] - range.length;
  UITextField *usernameTextfield = self.usernameTextField;
  UITextField *passwordTextfield = self.passwordTexField;
  
  if ( (textField == usernameTextfield && newLength > 255)
      || (textField == passwordTextfield && newLength > 255)) {
    return NO;
  }
  
  return YES;
}

- (void)onTextFieldDidChange:(id __unused)sender
{
  [self updateLoginButton];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  UITextField *usernameTextfield = [self usernameTextField];
  UITextField *passwordTextfield = [self passwordTexField];
  
  [textField resignFirstResponder];
  
  if ( usernameTextfield == textField ) {
    [passwordTextfield becomeFirstResponder];
  }
  
  return YES;
}


@end
