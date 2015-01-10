//
//  UIBarButtonItem+NavItem.h
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 07.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NavItem)

+ (UIBarButtonItem*)buttonWithTitle:(NSString*)title selector:(SEL)selector target:(id)target;


@end
