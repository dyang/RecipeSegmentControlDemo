//
//  SegmentButtonView.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SegmentButtonView.h"

#define IMAGE_TOP_OFFSET 12
#define SLIDE_DURATION 0.4

@interface SegmentButtonView ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImage *normalImage;
@property(nonatomic, strong) UIImage *highlightImage;

- (void)highlightSegment:(BOOL)animation;
- (void)segmentTapped;

@end

@implementation SegmentButtonView

@synthesize normalImage = _normalImage;
@synthesize highlightImage = _highlightImage;
@synthesize imageView = _imageView;
@synthesize tapGestureRecognizer = _tapGestureRecognizer;
@synthesize highlighted = _highlighted;

- (SegmentButtonView *)initWithTitle:(NSString *)title
                         normalImage:(UIImage *)normalImage
                      highlightImage:(UIImage *)highlightImage {
    self = [super init];
    if (self) {
        self.normalImage = normalImage;
        self.highlightImage = highlightImage;

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

- (void)setHighlighted:(BOOL)aHighlighted {
    [self highlightSegment:NO];
    _highlighted = aHighlighted;
}

- (void)highlightSegment:(BOOL)animated {
    // Do nothing if the current segment is already highlighted
    if (self.highlighted) return;


    NSTimeInterval slideDuration = animated ? SLIDE_DURATION : 0;
    [UIView animateWithDuration:slideDuration delay:0
                        options:UIViewAnimationOptionCurveEaseIn animations:^void() {
        self.imageView.frame = CGRectOffset(self.imageView.frame, 0, IMAGE_TOP_OFFSET);
    }                completion:^void(BOOL finished) {
        // Update image
        self.imageView.highlighted = YES;
    }];
}

- (void)segmentTapped {
    [self highlightSegment:YES];
}

- (void)dealloc {
    [self removeGestureRecognizer:self.tapGestureRecognizer];
}

@end
