//
//  LoginTests.m
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 10.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <KIFTestCase.h>
#import <KIF.h>
#import "ViewController.h"
#import <OCMock/OCMock.h>
#import <Parse/Parse.h>
#import <objc/runtime.h>
#import "DBLogin.h"

@interface LoginTests : KIFTestCase

@end

@implementation LoginTests

-(void)beforeAll
{
  [tester waitForViewWithAccessibilityLabel:NSLocalizedString(@"Hello World", nil)];
  [Parse setApplicationId:@"yAfWGQ6EHLqwHySHNNzJ646MX78gF5U3YRwBvYUi"
                clientKey:@"eXxCsdRg8YvXd2B9KjseC0pPbqzJJIPtprO44etq"];

}

-(void)beforeEach
{
  [self resetUsernameAndPassword];
}

-(void)testLoginButtonDisabledWhenTextfieldsEmpty
{
  UITextField *usernameTextfield = [self getUsernameTextfield];
  UITextField *passwordTextfield = [self getPasswordTextfield];
  UIBarButtonItem *loginButton = [self getLoginButton];
  
  XCTAssertFalse(usernameTextfield.text.length);
  XCTAssertFalse(passwordTextfield.text.length);
  XCTAssertFalse(loginButton.isEnabled);
}

-(void)testUsernameWithWrongFormatShowsErrorMessage
{
  //GIVEN
  [tester tapViewWithAccessibilityLabel:@"username"];
  [tester enterTextIntoCurrentFirstResponder:@"not an email"];

  //When next button on keyboard is tapped
  [tester tapViewWithAccessibilityLabel:@"next"];
  
  //Then
  [tester waitForViewWithAccessibilityLabel:@"Wrong email format"];
  
  UITextField *username = [self getUsernameTextfield];
  XCTAssertTrue(username.textColor == [UIColor redColor]);
  
  // After 4 seconds
  [tester waitForTimeInterval:4];
  [tester waitForAbsenceOfViewWithAccessibilityLabel:@"Wrong email format"];
  [tester waitForKeyInputReady];
}

-(void)testShortPasswordShowsErrorMessage
{
  //GIVEN
  [tester tapViewWithAccessibilityLabel:@"password"];
  [tester enterTextIntoCurrentFirstResponder:@"12345"];
  
  //When next button on keyboard is tapped
  [tester tapViewWithAccessibilityLabel:@"done"];
  
  //Then
  [tester waitForViewWithAccessibilityLabel:@"Password is to short (min 6 characters)"];
  
  UITextField *password = [self getPasswordTextfield];
  XCTAssertTrue(password.textColor == [UIColor redColor]);
  
  // After 4 seconds
  [tester waitForTimeInterval:4];
  [tester waitForAbsenceOfViewWithAccessibilityLabel:@"Password is to short (min 6 characters)"];
  [tester waitForAbsenceOfSoftwareKeyboard];
}


-(void)testLoginIsEnabledWhenUsernameAndPasswordAreFilledIn
{
  [tester tapViewWithAccessibilityLabel:@"username"];
  [tester enterTextIntoCurrentFirstResponder:@"d@b.com"];
  [tester tapViewWithAccessibilityLabel:@"next"];
  [tester enterTextIntoCurrentFirstResponder:@"123456"];
  UIBarButtonItem *loginButton = [self getLoginButton];
  XCTAssertTrue(loginButton.isEnabled);
}

-(void)testLoginReturnsAccountWrongCredentials
{
  [self setupLoginControllerToRespondeWithError:[NSError errorWithDomain:@"Parse" code:101 userInfo:nil]];
  [tester enterText:@"d@b.co" intoViewWithAccessibilityLabel:@"username"];
  [tester enterText:@"1234567das" intoViewWithAccessibilityLabel:@"password"];

  [tester tapViewWithAccessibilityLabel:@"login"];
  [tester waitForViewWithAccessibilityLabel:@"Wrong username or password"];
  [tester tapViewWithAccessibilityLabel:@"OK"];
}

-(void)testLoginReturnsAccountWrongPassword
{
  [self setupLoginControllerToRespondeWithError:[NSError errorWithDomain:@"Parse" code:101 userInfo:nil]];
  [tester enterText:@"d@b.co" intoViewWithAccessibilityLabel:@"username"];
  [tester enterText:@"1234567das" intoViewWithAccessibilityLabel:@"password"];
  [tester tapViewWithAccessibilityLabel:@"login"];
  [tester waitForViewWithAccessibilityLabel:@"Wrong username or password"];
  [tester tapViewWithAccessibilityLabel:@"OK"];
}

-(void)testLoginSuccessfullyPushNewViewController
{

  [self setupLoginControllerToRespondeWithError:nil];
  [tester enterText:@"d@b.co" intoViewWithAccessibilityLabel:@"username"];
  [tester enterText:@"123456asd" intoViewWithAccessibilityLabel:@"password"];
  [tester tapViewWithAccessibilityLabel:@"login"];
  [tester waitForViewWithAccessibilityLabel:@"loggedIn"];
  [tester tapViewWithAccessibilityLabel:@"Hello World"];
}

#pragma mark - DBLogin Controller

-(void)setupLoginControllerToRespondeWithError:(NSError*)error
{
  id parseUser = OCMProtocolMock(@protocol(DBLogin));
  
  [[[parseUser stub] andDo:^(NSInvocation *invocation) {
    
    void (^ failBlock)(PFUser *user , NSError *error) = nil;
    
    [invocation getArgument:&failBlock atIndex:4];
    failBlock( [PFUser currentUser], error);
    
  }] logInWithUsernameInBackground:[OCMArg any] password:[OCMArg any] block:[OCMArg any]];
  
  ViewController *loginViewController = (ViewController*)((UIView *)[tester waitForViewWithAccessibilityLabel:NSLocalizedString(@"login_view", nil)].nextResponder);
  
  [loginViewController setLoginController:parseUser];
}


#pragma mark - helper methods

-(UITextField*)getUsernameTextfield
{
  return (UITextField*)[tester waitForViewWithAccessibilityLabel:@"username"];
}

-(UITextField*)getPasswordTextfield
{
  return (UITextField*)[tester waitForViewWithAccessibilityLabel:@"password"];
}

-(UIBarButtonItem*)getLoginButton
{
  return (UIBarButtonItem*)[tester waitForViewWithAccessibilityLabel:@"login"];
}

-(void)resetUsernameAndPassword
{
  [tester tapViewWithAccessibilityLabel:@"username"];
  [tester clearTextFromViewWithAccessibilityLabel:@"username"];
  [tester tapViewWithAccessibilityLabel:@"password"];
  [tester clearTextFromViewWithAccessibilityLabel:@"password"];
}
@end
