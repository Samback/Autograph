//
//  jotViewController.m
//  Autograph
//
//  Created by Max on 20.08.12.
//  Copyright (c) 2012 Max. All rights reserved.
//

#import "jotViewController.h"
#import "jotAutographView.h"
@interface jotViewController ()<jotAutographViewDelegate>
@property (weak, nonatomic)  UIImageView *showAutograph;

@end

@implementation jotViewController
@synthesize showAutograph;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView * autograpPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.showAutograph = autograpPicture;
    [self.view addSubview:self.showAutograph];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:[[jotAutographView alloc] initWithSuperFrame:self.view.frame theDelegate:self theSize:CGSizeMake(500, 500) andTitle:@"Total price: 400 pounds."]];
}
                           

- (void)viewDidUnload
{
    [self setShowAutograph:nil];
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

#pragma mark - jotAutographViewDelegate
-(void) autographImage:(UIImage *) autograph
{
    self.showAutograph.image = autograph;
}

@end
