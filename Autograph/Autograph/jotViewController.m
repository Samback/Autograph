//
//  jotViewController.m
//  Autograph
//
//  Created by Max on 20.08.12.
//  Copyright (c) 2012 Max. All rights reserved.
//

#import "jotViewController.h"
#import "SmoothLineView.h"


@interface jotViewController ()

@end

@implementation jotViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     [self.view addSubview:[[SmoothLineView alloc] initWithFrame:self.view.bounds]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
