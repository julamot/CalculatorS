//
//  CalculatorViewController.h
//  CalculatorS
//
//  Created by Julie Zachman on 1/3/12.
//  Copyright (c) 2012 TomoTherapy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
// outlets are almost always weak
@property (weak, nonatomic) IBOutlet UILabel *display;

@end
