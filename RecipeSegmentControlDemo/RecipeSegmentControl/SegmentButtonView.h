//
//  SegmentButtonView.h
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface SegmentButtonView : UIView

@property(nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

- (SegmentButtonView *)initWithTitle:(NSString *)title
                         normalImage:(UIImage *)normalImage
                      highlightImage:(UIImage *)highlightImage;

@end
