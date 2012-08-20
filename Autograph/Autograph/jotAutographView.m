//
//  jotAutographView.m
//  Autograph
//
//  Created by Max on 20.08.12.
//  Copyright (c) 2012 Max. All rights reserved.
//

#import "jotAutographView.h"
#import "SmoothLineView.h"
#import <QuartzCore/QuartzCore.h>

#define VIEW_BACKGROUND_COLOR [UIColor lightGrayColor]
#define PRICE_LABEL_COLOR     [UIColor whiteColor]
#define PRICE_LABEL_FONT      [UIFont italicSystemFontOfSize:22]
#define ALERT_TITLE           @"Autograph"
#define ALERT_MESSAGE         @"Do you confirm this autograph?"


@interface jotAutographView()<UIAlertViewDelegate>
@property (nonatomic, strong) UIButton *acceptAutograph;
@property (nonatomic, strong) UIButton *clearAutograph;
@property (nonatomic, strong) UILabel  * priceLabel;
@property (nonatomic, strong) SmoothLineView * autographField;
@property (nonatomic, strong) NSString * priceTitle;
@property (nonatomic        ) CGSize viewSize;
@end

const CGFloat PRICE_LABEL_HEIGHT = 30.0;
const CGFloat BUTTONS_HEIGHT     = 44.0;
const CGFloat DELTA_HEIGHT       = 10.0;
const CGFloat BUTTONS_WIDTH      = 120.0;
const CGFloat MARGINE_SIDE       = 2.0;

NSString * CLEAR_BUTTON_TITLE  = @"Clear";
NSString * ACCEPT_BUTTON_TITLE = @"Accept";



@implementation jotAutographView
@synthesize autographDelegate = _autographDelegate;
@synthesize priceTitle = _priceTitle;
@synthesize acceptAutograph = _acceptAutograph;
@synthesize clearAutograph = _clearAutograph;
@synthesize priceLabel = _priceLabel;
@synthesize autographField = _autographField;
@synthesize viewSize = _viewSize;

- (id)initWithSuperFrame:(CGRect)superFrame theDelegate:(id<jotAutographViewDelegate>)delegate theSize:(CGSize) inputSize andTitle:(NSString *) price
{
    CGFloat autographHeight = inputSize.height;
    CGFloat autographWidth  = inputSize.width;
    self.viewSize  = inputSize;
    CGFloat xPos = (superFrame.size.width - autographWidth)/2;
    CGFloat yPos = (superFrame.size.height - autographHeight)/2;    
    CGRect rect = CGRectMake(xPos, yPos, autographWidth, autographHeight);
    self = [super initWithFrame:rect];
    if (self) {
        // Initialization code
        self.autographDelegate = delegate;
        self.priceTitle = price;
        [self initComponents];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{

}
 */

-(void) initComponents
{
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    CGFloat bootom = DELTA_HEIGHT;
    [self setBackgroundColor:VIEW_BACKGROUND_COLOR];
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGINE_SIDE, bootom, self.frame.size.width - 2 * MARGINE_SIDE, PRICE_LABEL_HEIGHT)];
    [self.priceLabel setBackgroundColor:PRICE_LABEL_COLOR];
    self.priceLabel.text = _priceTitle;
    self.priceLabel.font = PRICE_LABEL_FONT;
    self.priceLabel.textAlignment = UITextAlignmentCenter;
    self.priceLabel.layer.cornerRadius = 5;
    self.priceLabel.layer.masksToBounds = YES;
    [self addSubview:_priceLabel];
    bootom += PRICE_LABEL_HEIGHT + DELTA_HEIGHT;
    CGFloat autographHeight = self.frame.size.height - PRICE_LABEL_HEIGHT - BUTTONS_HEIGHT - 4 * DELTA_HEIGHT;
    
    self.autographField = [[SmoothLineView alloc] initWithFrame:CGRectMake(MARGINE_SIDE, bootom, self.frame.size.width - 2 * MARGINE_SIDE, autographHeight)];
    [self addSubview:_autographField];
    bootom += autographHeight + DELTA_HEIGHT;
    CGFloat deltaWidth = (self.frame.size.width - 2 * BUTTONS_WIDTH) / 3;
    CGRect clearButtonRect = CGRectMake(deltaWidth, bootom, BUTTONS_WIDTH, BUTTONS_HEIGHT); 
    self.clearAutograph = [UIButton buttonWithType:UIButtonTypeRoundedRect];//[[UIButton alloc]initWithFrame:clearButtonRect];
    self.clearAutograph.frame = clearButtonRect;
    [self.clearAutograph addTarget:self action:@selector(clearScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.clearAutograph setTitle:CLEAR_BUTTON_TITLE forState:UIControlStateNormal];
      [self addSubview:self.clearAutograph];
    CGRect acceptButtonRect = CGRectMake( 2 * deltaWidth + BUTTONS_WIDTH, bootom, BUTTONS_WIDTH, BUTTONS_HEIGHT);
    self.acceptAutograph =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.acceptAutograph.frame = acceptButtonRect;
    [self.acceptAutograph setTitle:ACCEPT_BUTTON_TITLE forState:UIControlStateNormal];
    [self.acceptAutograph addTarget:self action:@selector(acceptAutographFromScreen) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.acceptAutograph];    
}

-(void) clearScreen
{
    CGRect rect = _autographField.frame;
    [self.autographField removeFromSuperview];
    self.autographField = [[SmoothLineView alloc] initWithFrame:rect];
    [self addSubview:_autographField];
}

-(void) acceptAutographFromScreen
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:ALERT_MESSAGE delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];  
}

-(void)redrawWithNewFrame:(CGRect)newFrame
{
    CGFloat autographHeight = self.frame.size.height;
    CGFloat autographWidth  = self.frame.size.width;
    CGFloat xPos = (newFrame.size.width - autographWidth)/2;
    CGFloat yPos = (newFrame.size.height - autographHeight)/2;
    CGRect rect = CGRectMake(xPos, yPos, autographWidth, autographHeight);
    self.frame = rect;
}

#pragma mark - UIAlertViewDelegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self clearScreen];
    }else if(buttonIndex == 1)
    {
        UIGraphicsBeginImageContextWithOptions(self.autographField.frame.size, YES, 0.0f);
        [self.autographField.layer renderInContext:UIGraphicsGetCurrentContext()];        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.autographDelegate autographImage:image];
    }
}


@end
