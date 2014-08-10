//
//  ViewController.m
//  CustomUIActionSheet
//
//  Created by Barrett Breshears on 8/7/14.
//  Copyright (c) 2014 Barrett Breshears. All rights reserved.
//

#import "ViewController.h"
#import "CustomActionSheet.h"

@interface ViewController () <CustomActionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showActionSheet:(id)sender{
    CustomActionSheet *actionSheet = [[CustomActionSheet alloc] initWithTitle:@"Awesome Action Sheet" delegate:self cancelButtonTitle:@"All Done" otherButtonTitles:@"First Button", @"Second Button", @"My Favorite Button", nil];
    [actionSheet showAlert];
}

-(void)modalAlertPressed:(CustomActionSheet *)alert withButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld", (long)buttonIndex);
}

@end
