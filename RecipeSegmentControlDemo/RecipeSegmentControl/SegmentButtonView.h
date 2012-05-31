//
//  SegmentButtonView.h
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//

@protocol SegmentButtonViewDelegate;

@interface SegmentButtonView : UIView

- (SegmentButtonView *)initWithTitle:(NSString *)title
                         normalImage:(UIImage *)normalImage
                      highlightImage:(UIImage *)highlightImage
                            delegate:(id <SegmentButtonViewDelegate>)delegate;
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@end

@protocol SegmentButtonViewDelegate <NSObject>

- (void)segmentButtonHighlighted:(SegmentButtonView *)highlightedSegmentButton;

@end
