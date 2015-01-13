//
//  DBLogin.h
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 12.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DBLogin <NSObject>

-(void)logInWithUsernameInBackground:(NSString*)username password:(NSString*)password block:(void (^)(NSObject*, NSError*))completion;

-(void)loginWithFacebookAndCompletionBlock:(void (^) (NSObject*,NSError*))completion;

@end
