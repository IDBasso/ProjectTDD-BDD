//
//  UIBarButtonItem+NavItem.m
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 07.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import "UIBarButtonItem+NavItem.h"

@implementation UIBarButtonItem (NavItem)

+ (UIBarButtonItem*)buttonWithTitle:(NSString*)title selector:(SEL)selector target:(id)target
{
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
  [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
  button.layer.cornerRadius = 5;
  [button setTitle:NSLocalizedString(title, nil) forState:UIControlStateNormal];
  [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
  return item;
}


@end
