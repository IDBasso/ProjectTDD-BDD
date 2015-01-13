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
#import <Parse/Parse.h>
#import "DBParseLoginController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController
{
  UIBarButtonItem *_loginButton;
}

@synthesize loginController = _loginController;

#pragma mark - life cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = NSLocalizedString(@"login_screen_title", nil);
  self.usernameTextField.delegate = self;
  self.passwordTexField.delegate = self;
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
  
  [self setupLoginButton];
  
  self.usernameTextField.accessibilityLabel = @"username";
  self.passwordTexField.accessibilityLabel = @"password";
  self.view.accessibilityLabel = @"login_view";

  [self.inputsErrorMessage setHidden:YES];
  
  [self.usernameTextField setIsAccessibilityElement:YES];
  [self.passwordTexField setIsAccessibilityElement:YES];
  [self.view setIsAccessibilityElement:YES];
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
  _loginButton = [UIBarButtonItem buttonWithTitle:@"login" selector:@selector(login) target:self];
  [_loginButton setIsAccessibilityElement:YES];
  _loginButton.accessibilityLabel = NSLocalizedString(@"login_button_tittle", nil);
  self.navigationItem.rightBarButtonItem = _loginButton;
  [self updateLoginButton];
}

-(BOOL)updateLoginButton
{
  //TODO: Check if user name and password are filled in
  BOOL userDataIsFilledIn = (self.usernameTextField.text.length >= 1) && [self.usernameTextField.text isValidEmail] && (self.passwordTexField.text.length >= 1);
  [_loginButton setEnabled:userDataIsFilledIn];
  return userDataIsFilledIn;
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
    [self checkUsername];
    [passwordTextfield becomeFirstResponder];
  }else
  {
    [self checkPassword];
  }
  
  if ([self updateLoginButton]) {
    [self login];
  }
  
  return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
  if (textField == self.usernameTextField && self.passwordTexField.text.length) {
    [self checkPassword];
  }else if (self.usernameTextField.text.length)
    [self checkUsername];
}

-(void)checkUsername
{
  UITextField *usernameTextfield = [self usernameTextField];
  if (![usernameTextfield.text isValidEmail]) {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.inputsErrorMessage.text = NSLocalizedString(@"email_format_error", nil);
    self.inputsErrorMessage.textColor = [UIColor redColor];
    [self.inputsErrorMessage setHidden:NO];
    self.usernameTextField.textColor = [UIColor redColor];
    [self performSelector:@selector(hideErrorMessageWithTextfield:) withObject:usernameTextfield afterDelay:3];
  }
}

-(void)checkPassword
{
  UITextField *password = [self passwordTexField];
  if (password.text.length < 6) {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.inputsErrorMessage.text = NSLocalizedString(@"password_format_error", nil);
    self.inputsErrorMessage.textColor = [UIColor redColor];
    [self.inputsErrorMessage setHidden:NO];
    self.passwordTexField.textColor = [UIColor redColor];
    [self performSelector:@selector(hideErrorMessageWithTextfield:) withObject:password afterDelay:3];
  }
}

-(void)hideErrorMessageWithTextfield:(UITextField*)textfield
{
  [self.inputsErrorMessage setHidden:YES];
  textfield.textColor = [UIColor grayColor];
}

-(void)login
{
  [self.loginController logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTexField.text block:^(NSObject * user, NSError * error)
  {
    if (error) {
      NSString *errorMessage;
      switch (error.code) {
        case 101:
          errorMessage = NSLocalizedString(@"bad_authorization_error", nil);
          break;
        case 100:
          errorMessage = NSLocalizedString(@"server_connection_error", nil);
          break;
        case 1:
          errorMessage = NSLocalizedString(@"server_internal_error", nil);
          break;
        default:
          break;
      }
      NSLog(@"error : %@", [error description]);
      
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"errror_title", <#comment#>) message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"global_ok", nil), nil];
      [alertView show];
    }else
    {
      UIViewController *loggedInViewController = [[UIViewController alloc] init];
      loggedInViewController.view.accessibilityLabel = @"loggedIn";
      loggedInViewController.view.backgroundColor = [UIColor greenColor];
      [loggedInViewController.view setIsAccessibilityElement:YES];
      [self.navigationController pushViewController:loggedInViewController animated:YES];
    }
  }];
}

- (IBAction)loginWithFacebook:(UIButton *)sender {
  [self.loginController loginWithFacebookAndCompletionBlock:^(NSObject * user, NSError * error) {
    if (error) {
      NSLog(@"error %@", [error description]);
    }
  }];
}

-(id<DBLogin>)loginController
{
  if (!_loginController) {
    _loginController = [[DBParseLoginController alloc] init];
  }
  return _loginController;
}

-(void)setLoginController:(id<DBLogin>)loginController
{
  _loginController = loginController;
}

@end
