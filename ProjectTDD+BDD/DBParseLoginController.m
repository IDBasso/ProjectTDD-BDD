//
//  DBParseLoginController.m
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 12.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import "DBParseLoginController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@implementation DBParseLoginController

-(void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(void (^)(NSObject *, NSError *))completion
{
  [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
    
    completion(user,error);
    
  }];
}

-(void)loginWithFacebookAndCompletionBlock:(void (^)(NSObject *, NSError *))completion
{
  NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];

  [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
    completion(user,error);
  }];
}

@end
