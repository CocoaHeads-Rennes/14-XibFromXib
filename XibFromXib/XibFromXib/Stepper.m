//
//  Stepper.m
//  XibFromXib
//
//  Created by Thomas Dupont on 23/10/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "Stepper.h"

CGFloat const kStepperAnimationDuration = 0.3f;
NSInteger const kStepperClosedWidth = 40;
NSInteger const kStepperOpenedWidth = 140;

@interface Stepper ()

@property (nonatomic, strong) IBOutlet UIView* view;
@property (nonatomic, weak) IBOutlet UILabel* label;

@property (nonatomic, assign) NSInteger number;

@end

@implementation Stepper

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupStepper];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupStepper];
    }
    return self;
}

- (void)setupStepper
{
    self.number = 0;
    
    [[NSBundle mainBundle] loadNibNamed:@"Stepper" owner:self options:nil];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:self.view];
    
    UIView* view = self.view;
    NSDictionary* dict = NSDictionaryOfVariableBindings(view);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views:dict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:dict]];
    
    [self updateLayoutAnimated:NO];
    
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
        constant = kStepperClosedWidth;
    }
    else
    {
        constant = kStepperOpenedWidth;
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
    
    for (NSLayoutConstraint* constraint in [self constraints])
    {
        if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeWidth)
        {
            width = constraint;
        }
    }
    
    width.constant = constant;
    
    [self.superview setNeedsUpdateConstraints];
    
    if (animated)
    {
        [UIView animateWithDuration:kStepperAnimationDuration animations:^{
            [self.superview layoutIfNeeded];
        }];
    }
    else
    {
        [self.superview layoutIfNeeded];
    }
}

@end
