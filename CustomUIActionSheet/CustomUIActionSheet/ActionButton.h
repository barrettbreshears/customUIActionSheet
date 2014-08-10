//
//  ActionButton.h
//  CustomUIActionSheet
//
//  Created by Barrett Breshears on 8/8/14.
//  Copyright (c) 2014 Barrett Breshears. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionButton : UIButton

// class method that will be used when allocating button
+ (ActionButton *)buttonWithText:(NSString *)text cancel:(BOOL)cancel;

// instance method to set the button label and let the button know if it is a cancel button
- (id)initWithText:(NSString *)text cancel:(BOOL)cancel;

@property (nonatomic, retain) UILabel *label;

@end
