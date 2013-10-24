//
//  ViewController.m
//  XibFromXib
//
//  Created by Thomas Dupont on 23/10/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "ViewController.h"

#import "UglyStepper.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView* myFutureStepper;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"UglyStepper" owner:nil options:nil];
    if ([array count] > 0)
    {
        UIView* view = [array objectAtIndex:0];
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.myFutureStepper addSubview:view];
        
        NSDictionary* dict = NSDictionaryOfVariableBindings(view);
        
        [self.myFutureStepper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views:dict]];
        [self.myFutureStepper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:dict]];
        
        [(UglyStepper*)view updateLayoutAnimated:NO];
        
    }
}

@end
