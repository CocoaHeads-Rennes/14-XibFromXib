//
//  UglyStepper.m
//  XibFromXib
//
//  Created by Thomas Dupont on 23/10/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "UglyStepper.h"

CGFloat const kUglyStepperAnimationDuration = 0.3f;
NSInteger const kUglyStepperClosedWidth = 40;
NSInteger const kUglyStepperOpenedWidth = 140;

@interface UglyStepper ()

@property (nonatomic, weak) IBOutlet UILabel* label;

@property (nonatomic, assign) NSInteger number;

@end

@implementation UglyStepper

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (IBAction)handleMinusButtonTap:(id)sender
{
    if (self.number > 0)
    {
        self.number--;
        [self updateLayoutAnimated:YES];
    }
}

- (IBAction)handlePlusButtonTap:(id)sender
{
    self.number++;
    [self updateLayoutAnimated:YES];
}

- (void)updateLayoutAnimated:(BOOL)animated
{
    NSInteger constant = 0;
    
    if (self.number == 0)
    {
        constant = kUglyStepperClosedWidth;
    }
    else
    {
        constant = kUglyStepperOpenedWidth;
    }
    
    NSInteger number = self.number;
    
    if (number > 0)
    {
        [self.label setText:[NSString stringWithFormat:@"%i", self.number]];
    }
    else
    {
        [self.label setText:nil];
    }
    
    NSLayoutConstraint* width = nil;
    
    for (NSLayoutConstraint* constraint in [self.superview constraints])
    {
        if (constraint.firstItem == self.superview && constraint.firstAttribute == NSLayoutAttributeWidth)
        {
            width = constraint;
        }
    }
    
    width.constant = constant;
    
    [self.superview setNeedsUpdateConstraints];
    
    if (animated)
    {
        [UIView animateWithDuration:kUglyStepperAnimationDuration animations:^{
            [self.superview.superview layoutIfNeeded];
        }];
    }
    else
    {
        [self.superview.superview layoutIfNeeded];
    }
}


@end
