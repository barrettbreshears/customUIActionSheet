//
//  CustomActionSheet.h
//  CustomUIActionSheet
//
//  Created by Barrett Breshears on 8/7/14.
//  Copyright (c) 2014 Barrett Breshears. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomActionSheet;

// define the custom actionview delegate
@protocol CustomActionViewDelegate <NSObject>

@optional
// declare the option delegate method wich passed in the alert and which button was selected
- (void)modalAlertPressed:(CustomActionSheet *)alert withButtonIndex:(NSInteger)buttonIndex;

@end

@interface CustomActionSheet : UIView

@property (assign) id <CustomActionViewDelegate> delegate;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign) float yPosition;
@property (nonatomic, assign) int index;

- (void)animateOn;
- (void)animateOff;
- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (void)buttonPressedWithIndex:(id)sender;
- (void)showAlert;

@end
