//
//  SegmentButtonView.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SegmentButtonView.h"

#define IMAGE_TOP_OFFSET 12
#define ANIMATION_DURATION 0.2

@interface SegmentButtonView ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImage *normalImage;
@property(nonatomic, strong) UIImage *highlightImage;
@property(nonatomic, weak) id <SegmentButtonViewDelegate> delegate;

- (void)expandSegment:(BOOL)animation;
- (void)collapseSegment:(BOOL)animation;
- (void)segmentTapped;

@end

@implementation SegmentButtonView

@synthesize normalImage = _normalImage;
@synthesize highlightImage = _highlightImage;
@synthesize imageView = _imageView;
@synthesize tapGestureRecognizer = _tapGestureRecognizer;
@synthesize delegate = _delegate;

- (SegmentButtonView *)initWithTitle:(NSString *)title
                         normalImage:(UIImage *)normalImage
                      highlightImage:(UIImage *)highlightImage
                            delegate:(id <SegmentButtonViewDelegate>)delegate {
    self = [super init];
    if (self) {
        self.normalImage = normalImage;
        self.highlightImage = highlightImage;
        self.delegate = delegate;

        // Set up images to display
        self.imageView = [[UIImageView alloc] initWithImage:self.normalImage
                                           highlightedImage:self.highlightImage];
        self.imageView.frame = CGRectMake(0, -IMAGE_TOP_OFFSET,
                self.normalImage.size.width, self.normalImage.size.height);
        [self addSubview:self.imageView];

        // Listen to single tap on segment
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(segmentTapped)];
        [self addGestureRecognizer:self.tapGestureRecognizer];

        self.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    // Nothing happens if we already have the desired highlight status.
    if (self.imageView.highlighted == highlighted) return;

    if (highlighted) {
        [self expandSegment:animated];
    } else {
        [self collapseSegment:animated];
    }
}

- (void)expandSegment:(BOOL)animation {
    NSTimeInterval animationDuration = animation ? ANIMATION_DURATION : 0;
    [UIView animateWithDuration:animationDuration delay:0
                        options:UIViewAnimationOptionCurveEaseIn animations:^void() {
        self.imageView.frame = CGRectOffset(self.imageView.frame, 0, IMAGE_TOP_OFFSET);
    }                completion:^void(BOOL finished) {
        // Update image
        self.imageView.highlighted = YES;
    }];
}

- (void)collapseSegment:(BOOL)animation {
    NSTimeInterval animationDuration = animation ? ANIMATION_DURATION : 0;
    [UIView animateWithDuration:animationDuration delay:0
                        options:UIViewAnimationOptionCurveEaseIn animations:^void() {
        self.imageView.frame = CGRectOffset(self.imageView.frame, 0, -IMAGE_TOP_OFFSET);
    }                completion:^void(BOOL finished) {
        // Update image
        self.imageView.highlighted = NO;
    }];
}

- (void)segmentTapped {
    // Notify delegate for post processing
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentButtonHighlighted:)]) {
        [self.delegate segmentButtonHighlighted:self];
    }
}

- (void)dealloc {
    [self removeGestureRecognizer:self.tapGestureRecognizer];
}

@end
