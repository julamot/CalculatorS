//
//  CalculatorBrain.m
//  CalculatorS
//
//  Created by Julie Zachman on 1/11/12.
//  Copyright (c) 2012 TomoTherapy. All rights reserved.
//

#import "CalculatorBrain.h"
#import "math.h"

@interface CalculatorBrain()
@property(nonatomic, strong) NSMutableArray *programStack;
//@property(nonatomic, assign) double memory;
@property(nonatomic, strong) NSNumber *memory;
@end

@implementation CalculatorBrain
@synthesize programStack = _programStack;
@synthesize memory = _memory;
@synthesize curDisplayText = _curDisplayText;

// getter never returns nil
- (NSMutableArray *) programStack
{
    // lazy instantiation - only at last second
    if (_programStack == nil)
    {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}
// getter never returns nil
- (NSString *) curDisplayText
{
    // lazy instantiation - only at last second
    if (_curDisplayText == nil)
    {
        _curDisplayText = [[NSString alloc] init];
    }
    return _curDisplayText;
}

- (void) pushOperand:(double) operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

// The return from thi method is displayed 
- (double) performOperation:(NSString *) operation
{
    id topOfStack = [self.programStack lastObject];

    if ( [operation isEqualToString:@"Store"] && [topOfStack isKindOfClass:[NSNumber class]])
    {
        self.memory = [NSNumber numberWithDouble:[topOfStack doubleValue]];
        return [topOfStack doubleValue];
    }
    if ( [operation isEqualToString:@"Recall"])
    {
        // push the memory onto the stack
        [self.programStack addObject:[self.memory stringValue]];
        return [self.memory doubleValue]; 
    }
    
    
    // push the operation onto the stack and...
    [self.programStack addObject:operation];
    
    
    // ...run the program
    return [CalculatorBrain runProgram:self.program];
    // Note instead of calling runProgram as a class method can call
    // return [[self class] runProgram:self.program];  [self class] calls the current
    // class if we are not in a subclass, otherwise the inheritor will be referenced.
}

- (id) program
{
    // recall the copy message returns a copy that is a Mutable Array
    return [self.programStack copy];
}
    
+ (NSString *) descriptionOfProgram:(id)program
{
    return @"ToDo";
}

+ (double) popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) 
    {
        [stack removeLastObject];
    }
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString: @"+"]) 
        {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
        else if ( [operation isEqualToString:@"*"])
        {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if ( [operation isEqualToString:@"-"])
        {
            double stack_x = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - stack_x;
        }
        else if ( [operation isEqualToString:@"/"])
        {
            double stack_x = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] / stack_x;
        }
        else if ( [operation isEqualToString:@"1/x"])
        {
            double popped = [self popOperandOffStack:stack];
            if (popped != 0.0) 
            {
                result = 1/popped;
            }
        }
        else if ( [operation isEqualToString:@"+/-"])
        {
            result = -[self popOperandOffStack:stack];
        }
        else if ( [operation isEqualToString:@"sin"])
        {
            // assume user entered angle in degrees...
            double popped = [self popOperandOffStack:stack];
            // and convert degrees to radians inline
            result = sin(popped*M_PI/180);
        }
        else if ( [operation isEqualToString:@"cos"])
        {
            // see comment for sin()
            double popped = [self popOperandOffStack:stack];
            // conversion is from 360 degrees = 2*PI radians
            result = cos(popped*M_PI/180);
        }

    }     
   return result;
}

+ (double) runProgram:(id) program
{
    // Initialized to nil if iOS 5 or later
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

 - (NSString *)description
{
    return [NSString stringWithFormat:@"stack = %@", self.programStack];
}
   
@end
