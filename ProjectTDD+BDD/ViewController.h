//
//  ViewController.h
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 06.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBLogin.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTexField;
@property (weak, nonatomic) IBOutlet UILabel *inputsErrorMessage;
@property (nonatomic) id<DBLogin> loginController;


-(void)login;


@end

