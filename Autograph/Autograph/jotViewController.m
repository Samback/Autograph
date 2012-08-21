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
@property (nonatomic, strong) jotAutographView * autograph;

@end

@implementation jotViewController
@synthesize showAutograph;
@synthesize autograph = _autograph;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView * autograpPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.showAutograph = autograpPicture;
    [self.view addSubview:self.showAutograph];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.autograph = [[jotAutographView alloc] initWithSuperFrame:self.view.frame theDelegate:self theSize:CGSizeMake(500, 500) andTitle:@"Total price: 400 pounds."];
    [self.view addSubview:_autograph];
}
                           

- (void)viewDidUnload
{
    [self setShowAutograph:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UIDevice* thisDevice = [UIDevice currentDevice];
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
           [self.autograph redrawWithNewFrame:CGRectMake(0, 0, 1024, 768)];
        }
        else
        {
             [self.autograph redrawWithNewFrame:CGRectMake(0, 0, 480, 320)];
        }

         
    }else
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [self.autograph redrawWithNewFrame:CGRectMake(0, 0,  768, 1024)];
        }
        else
        {
             [self.autograph redrawWithNewFrame:CGRectMake(0, 0, 320, 480)];
        }       
    }
   
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
