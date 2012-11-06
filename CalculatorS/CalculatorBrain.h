//
//  CalculatorBrain.h
//  CalculatorS
//
//  Created by Julie Zachman on 1/11/12.
//  Copyright (c) 2012 TomoTherapy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double) operand;
- (double) performOperation:(NSString *) operation;

// no setter for the property if it's readonly
@property (readonly) id program;
@property (strong, nonatomic) NSString *curDisplayText;

// Class methods
+ (double) runProgram:(id) program;
+ (NSString *)descriptionOfProgram: (id) program;

@end
