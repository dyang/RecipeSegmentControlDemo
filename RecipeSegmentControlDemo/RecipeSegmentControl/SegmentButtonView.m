//
//  SegmentButtonView.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//

#import "SegmentButtonView.h"

#define TOP_OFFSET 10
#define ANIMATION_DURATION 0.2

@interface SegmentButtonView ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImage *normalImage;
@property(nonatomic, strong) UIImage *highlightImage;
@property(nonatomic, weak) id <SegmentButtonViewDelegate> delegate;
@property(nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) UIColor *shadowColor;
@property(nonatomic, strong) UIColor *highlightShadowColor;

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
@synthesize label = _label;
@synthesize textColor = _textColor;
@synthesize shadowColor = _shadowColor;
@synthesize highlightShadowColor = _highlightShadowColor;

- (SegmentButtonView *)initWithTitle:(NSString *)title
                         normalImage:(UIImage *)normalImage
                      highlightImage:(UIImage *)highlightImage
                            delegate:(id <SegmentButtonViewDelegate>)delegate {
    self = [super init];
    if (self) {
        self.normalImage = normalImage;
        self.highlightImage = highlightImage;
        self.delegate = delegate;
        self.textColor = [UIColor colorWithRed:51.0 / 255.0 green:26.0 / 255.0 blue:3.0 / 255.0 alpha:1.0];
        self.shadowColor = [UIColor colorWithRed:192.0 / 255.0 green:177.0 / 255.0 blue:161.0 / 255.0 alpha:1.0];
        self.highlightShadowColor = [UIColor colorWithRed:212.0 / 255.0 green:200.0 / 255.0 blue:187.0 / 255.0 alpha:1.0];

        // Set up images to display
        self.imageView = [[UIImageView alloc] initWithImage:self.normalImage
        highlightedImage:self.highlightImage];
        self.imageView.frame = CGRectMake(0, -TOP_OFFSET,
        self.normalImage.size.width, self.normalImage.size.height);
        [self addSubview:self.imageView];

        // Listen to single tap on segment
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
        action:@selector(segmentTapped)];
        [self addGestureRecognizer:self.tapGestureRecognizer];

        // Set up title
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, self.normalImage.size.width, 20)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont boldSystemFontOfSize:13];
        self.label.textColor = self.textColor;
        self.label.shadowColor = self.shadowColor;
        self.label.shadowOffset = CGSizeMake(1, 1);
        self.label.textAlignment = UITextAlignmentCenter;
        self.label.text = title;
        [self addSubview:self.label];

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
        self.imageView.frame = CGRectOffset(self.imageView.frame, 0, TOP_OFFSET);
        self.label.frame = CGRectOffset(self.label.frame, 0, TOP_OFFSET);
    }                completion:^void(BOOL finished) {
        self.imageView.highlighted = YES;
        self.label.shadowColor = self.highlightShadowColor;
    }];
}

- (void)collapseSegment:(BOOL)animation {
    NSTimeInterval animationDuration = animation ? ANIMATION_DURATION : 0;
    [UIView animateWithDuration:animationDuration delay:0
                        options:UIViewAnimationOptionCurveEaseIn animations:^void() {
        self.imageView.frame = CGRectOffset(self.imageView.frame, 0, -TOP_OFFSET);
        self.label.frame = CGRectOffset(self.label.frame, 0, -TOP_OFFSET);
    }                completion:^void(BOOL finished) {
        self.imageView.highlighted = NO;
        self.label.shadowColor = self.shadowColor;
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
