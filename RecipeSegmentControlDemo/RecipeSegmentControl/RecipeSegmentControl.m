//
//  RecipeSegmentControl.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecipeSegmentControl.h"
#import "SegmentButtonView.h"
#import <QuartzCore/QuartzCore.h>

@interface RecipeSegmentControl ()

@property (nonatomic, strong) NSArray *segmentButtons;

- (void)setUpSegmentButtons;

@end

@implementation RecipeSegmentControl

@synthesize segmentButtons = _segmentButtons;

- (id)init {
    self = [super init];
    if (self) {
        // Set up layer in order to clip any drawing that is done outside of self.bounds
        self.layer.masksToBounds = YES;

        // Set up segment buttons
        [self setUpSegmentButtons];

        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0,
                [[UIScreen mainScreen] applicationFrame].size.width,
                [UIImage imageNamed:@"recipe_tab_1.png"].size.height);
    }
    return self;
}

- (void)setUpSegmentButtons {
    SegmentButtonView *segment1 = [[SegmentButtonView alloc] initWithTitle:@"Summary"
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_1.png"]
            highlightImage:[UIImage imageNamed:@"recipe_tab_1_active.png"]
            delegate:self];
    SegmentButtonView *segment2 = [[SegmentButtonView alloc] initWithTitle:@"You'll need"
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_2.png"]
            highlightImage:[UIImage imageNamed:@"recipe_tab_2_active.png"]
            delegate:self];
    SegmentButtonView *segment3 = [[SegmentButtonView alloc] initWithTitle:@"Steps"
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_3.png"]
            highlightImage:[UIImage imageNamed:@"recipe_tab_3_active.png"]
            delegate:self];

    segment1.frame = CGRectOffset(segment1.frame, 0, 0);
    segment2.frame = CGRectOffset(segment2.frame, segment1.frame.size.width, 0);
    segment3.frame = CGRectOffset(segment3.frame, segment1.frame.size.width + segment2.frame.size.width, 0);

    // Highlight the first segment
    [segment1 setHighlighted:YES animated:NO];

    [self addSubview:segment1];
    [self addSubview:segment2];
    [self addSubview:segment3];

    self.segmentButtons = [NSArray arrayWithObjects:segment1, segment2, segment3, nil];
}

#pragma mark - SegmentButtonViewDelegate

- (void)segmentButtonHighlighted:(SegmentButtonView *)highlightedSegmentButton {
    for (SegmentButtonView *segmentButton in self.segmentButtons) {
        if ([segmentButton isEqual:highlightedSegmentButton]) {
            [segmentButton setHighlighted:YES animated:YES];
        } else {
            [segmentButton setHighlighted:NO animated:YES];
        }
    }
}

@end
