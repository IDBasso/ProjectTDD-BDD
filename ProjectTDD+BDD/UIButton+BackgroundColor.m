//
//  UIButton+BackgroundColor.m
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 06.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import "UIButton+BackgroundColor.h"
#import "UIImage+Color.h"
@implementation UIButton (BackgroundColor)

-(void)setEnabled:(BOOL)enabled
{
  [super setEnabled:enabled];
  
  if (enabled) {
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.21 green:0.71 blue:0.58 alpha:1]] forState:UIControlStateNormal];
  }else
  {
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.21 green:0.71 blue:0.58 alpha:0.2]] forState:UIControlStateDisabled];
  }
}

@end
