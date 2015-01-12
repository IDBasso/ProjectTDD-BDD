//
//  SignupTests.m
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 11.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <KIF/KIF.h>

@interface SignupTests : KIFTestCase

@end

@implementation SignupTests

- (void)beforeAll
{
  [tester waitForViewWithAccessibilityLabel:@"Hello World"];
  [tester tapViewWithAccessibilityLabel:@"Sign up now"];
  [tester waitForViewWithAccessibilityLabel:@"Sign up"];
}

-(void)testLoginEnabledWhenUserEntersAllCredentials
{
  UIBarButtonItem *signupButton = (UIBarButtonItem*)[tester waitForViewWithAccessibilityLabel:@"signup"];
  XCTAssertFalse(signupButton.isEnabled);
  [tester tapViewWithAccessibilityLabel:@"firstname"];
  [tester enterText:@"My first name" intoViewWithAccessibilityLabel:@"firstname"];
  [tester tapViewWithAccessibilityLabel:@"next"];
  [tester enterTextIntoCurrentFirstResponder:@"My last name"];
  [tester tapViewWithAccessibilityLabel:@"next"];
  [tester enterTextIntoCurrentFirstResponder:@"d@basso.com"];
  [tester tapViewWithAccessibilityLabel:@"Next"];
  [tester enterTextIntoCurrentFirstResponder:@"123456"];
  XCTAssertTrue(signupButton.isEnabled);
}

@end
