//
//  ActionButton.m
//  CustomUIActionSheet
//
//  Created by Barrett Breshears on 8/8/14.
//  Copyright (c) 2014 Barrett Breshears. All rights reserved.
//

#import "ActionButton.h"

@implementation ActionButton

+ (ActionButton *)buttonWithText:(NSString *)text cancel:(BOOL)cancel
{
    // return the initalized button
    return [[self alloc] initWithText:text cancel:(BOOL)cancel];
}

- (id)initWithText:(NSString *)text cancel:(BOOL)cancel
{
    // initialize
    self = [super init];
    if (self != nil) {
        
        // we are only using a single image for the demo, but this project is set up for
        // an image with a highligted state
        UIImage *mainImage;
        UIImage *tappedImage;
        
        // check if the image is a cancel button, if it is  we will use a special image
        if (cancel) {
            mainImage = [UIImage imageNamed:@"red_button.png"];
            tappedImage = [UIImage imageNamed:@"red_button.png"];
        } else { // otherwise the default button image will be a green button
            mainImage = [UIImage imageNamed:@"green_button.png"];
            tappedImage = [UIImage imageNamed:@"green_button.png"];
        }
        
        // create the buttons frame based on the image size
        CGRect frame;
        frame.size = mainImage.size;
        self.frame = frame;
        
        // set button images
        [self setImage:mainImage forState:UIControlStateNormal];
        [self setImage:tappedImage forState:UIControlStateHighlighted];
        
        // set up button label
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = text;
        [self addSubview:_label];
    }
    return self;
}

@end
