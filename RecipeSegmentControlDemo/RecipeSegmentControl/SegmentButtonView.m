//
//  SegmentButtonView.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SegmentButtonView.h"

#define IMAGE_TOP_OFFSET 12

@interface SegmentButtonView ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImage *normalImage;
@property(nonatomic, strong) UIImage *highlightImage;

@end

@implementation SegmentButtonView

@synthesize normalImage = _normalImage;
@synthesize highlightImage = _highlightImage;
@synthesize imageView = _imageView;


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

        self.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    }
    return self;
}

@end
