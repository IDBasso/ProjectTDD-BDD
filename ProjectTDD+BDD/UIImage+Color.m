//
//  UIImage+Color.m
//  ProjectTDD+BDD
//
//  Created by Diana Basso on 06.01.15.
//  Copyright (c) 2015 Diana Basso. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color {
  CGRect rect = CGRectMake(0, 0, 1, 1);
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
  [color setFill];
  UIRectFill(rect); 
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

@end
