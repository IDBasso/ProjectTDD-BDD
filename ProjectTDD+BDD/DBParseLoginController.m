//
//  DBParseLoginController.m
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 12.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import "DBParseLoginController.h"
#import <Parse/Parse.h>

@implementation DBParseLoginController

-(void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(void (^)(PFUser *, NSError *))completion
{
  [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
    
    completion(user,error);
    
  }];
}

@end
