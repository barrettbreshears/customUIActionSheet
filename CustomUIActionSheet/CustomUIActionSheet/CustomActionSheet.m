//
//  CustomActionSheet.m
//  CustomUIActionSheet
//
//  Created by Barrett Breshears on 8/7/14.
//  Copyright (c) 2014 Barrett Breshears. All rights reserved.
//

#import "CustomActionSheet.h"
#import "ActionButton.h"

@interface CustomActionSheet ()

@end

@implementation CustomActionSheet
@synthesize backgroundView;
@synthesize yPosition;
@synthesize index;

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        
        // set the delegate
        _delegate = delegate;
        
        // create a frame this will take up the full screen size
        self.frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
        
        // set up the background view
        backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithRed:7.0/255.0f green:45.0/255.0f blue:58.0/255.0 alpha:1];
        backgroundView.userInteractionEnabled = YES;
        CGRect frame = backgroundView.frame;
        frame.size = CGSizeMake(320, 380);
        frame.origin = CGPointMake(0, self.frame.size.height);
        backgroundView.frame = frame;
        
        
        // get our button array from the otherButtonTittles parameter
        NSMutableArray *buttonArray = [[NSMutableArray alloc]init];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*))
        {
            [buttonArray addObject:arg];
        }
        va_end(args);
        
        
        // this will track the current postion of where the elements will be placed
        yPosition = 15;
        
        // check if there is a title
        if (title != nil) {
            // create a the title and position it in the view
            UILabel *titleField = [[UILabel alloc] init];
            titleField.textColor = [UIColor whiteColor];
            titleField.shadowColor = [UIColor blackColor];
            [titleField setTextAlignment:NSTextAlignmentCenter];
            titleField.text = title;
            frame = titleField.frame;
            frame.size.width = self.frame.size.width ;
            frame.size.height = 19;
            frame.origin.x = self.frame.size.width/2 - frame.size.width/2;
            frame.origin.y = yPosition;
            titleField.frame = frame;
            [backgroundView addSubview:titleField];
            yPosition += titleField.frame.size.height + 10;
        }
        
        // i will be used to set the button's tag and is returned to delegate menthod
        int i;
        // loop through the buttons and create an ActionButton for each
        for (i = 0; i < buttonArray.count; i++) {
            ActionButton *alertButton = [ActionButton buttonWithText:[buttonArray objectAtIndex:i] cancel:NO];
            frame = alertButton.frame;
            frame.origin.x = backgroundView.frame.size.width/2 - frame.size.width/2;
            frame.origin.y = yPosition;
            alertButton.frame = frame;
            alertButton.tag = i;
            [alertButton addTarget:self action:@selector(buttonPressedWithIndex:) forControlEvents:UIControlEventTouchUpInside];
            [backgroundView addSubview:alertButton];
            yPosition += alertButton.frame.size.height + 10;
            
        }
        
        // increase the tag index for the cancel button
        i++;
        
        // create the cancel button
        ActionButton * cancel = [ActionButton buttonWithText:cancelButtonTitle cancel:YES];
        frame = cancel.frame;
        frame.origin.x = backgroundView.frame.size.width/2 - frame.size.width/2;
        frame.origin.y = yPosition;
        cancel.frame = frame;
        cancel.tag = i;
        [cancel addTarget:self action:@selector(buttonPressedWithIndex:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:cancel];
        
        yPosition += cancel.frame.size.height + 15;
        
        frame = backgroundView.frame;
        frame.size.width = self.frame.size.width;
        frame.size.height = yPosition;
        backgroundView.frame = frame;
        
        // add the background view and animate the view on screen
        [self addSubview:backgroundView];
        [self animateOn];
        
        
    }
    return self;
}

// method that is fired when one of the ActionButtons is pressed
- (void)buttonPressedWithIndex:(id)sender
{
    // get the button that was pressed
    ActionButton *button = (ActionButton *)sender;
    index = (int)button.tag;
    [self animateOff];
}


// shows the action sheet by adding it to the key window
- (void)showAlert
{
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
}


// animate the view on to the screen
- (void)animateOn
{
    [UIView animateWithDuration:.23 animations:^{
        
        CGRect frame = backgroundView.frame;
        frame.origin.y -= yPosition;
        backgroundView.frame = frame;
        
    }];
}

// remove the view with animation once removed the delegate method is fired off notifying the
// object that implemented the CustomActionSheet
- (void)animateOff
{
    [UIView animateWithDuration:.23 animations:^{
        
        CGRect frame = backgroundView.frame;
        frame.origin.y += yPosition;
        backgroundView.frame = frame;
        
    } completion:^(BOOL complete){
        [_delegate modalAlertPressed:self withButtonIndex:index];
        [self removeFromSuperview];
    }];
}



@end
