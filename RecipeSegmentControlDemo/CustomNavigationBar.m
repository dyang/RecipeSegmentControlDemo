//
//  CustomNavigationBar.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/31/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

- (void)awakeFromNib {
    [super awakeFromNib];

    // draw shadow underneath navigationBar
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

@end
