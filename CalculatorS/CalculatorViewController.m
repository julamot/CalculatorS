//
//  CalculatorViewController.m
//  CalculatorS
//
//  Created by Julie Zachman on 1/3/12.
//  Copyright (c) 2012 TomoTherapy. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfTypingANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize userIsInTheMiddleOfTypingANumber = _userIsInTheMiddleOfTypingANumber;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc ] init];
    
    return _brain;
}
// Convenience method to both set and store the display
- (void) displayText:(NSString *)text
{
    self.display.text = text;
    self.brain.curDisplayText = text;
    
}
// built-in primitive type id is pointer to any kind of object, or 
// pointer to *unknown*  object.  The argument is the sender of the message
// Change id to UIButton so it's easier to send correct messages to sender.
- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    
    if (self.userIsInTheMiddleOfTypingANumber)
    {
        [self displayText:[self.display.text stringByAppendingString:digit]];

    }
    else
    {
        [self displayText:digit];
        self.userIsInTheMiddleOfTypingANumber = YES;
    }
}
- (IBAction)pointPressed 
{
    NSString *point = @".";
    if (self.userIsInTheMiddleOfTypingANumber)
    {
        NSRange range = [self.display.text rangeOfString:point];
        // Only append a decimal point if it has not already been appended
        if (range.location == NSNotFound)
        {
//          self.display.text = [self.display.text stringByAppendingString:point];
            [self displayText:[self.display.text stringByAppendingString:point]];
        }
    }
    else
    {
//        self.display.text = point;
        [self displayText:point];
        self.userIsInTheMiddleOfTypingANumber = YES;
    }

}
- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfTypingANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfTypingANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle]; 
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    [self displayText:resultString];
}


@end
