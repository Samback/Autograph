//
//  jotAutographView.h
//  Autograph
//
//  Created by Max on 20.08.12.
//  Copyright (c) 2012 Max. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol jotAutographViewDelegate
-(void) autographImage:(UIImage *) autograph;
@end

@interface jotAutographView : UIView
@property (nonatomic, unsafe_unretained) id<jotAutographViewDelegate>autographDelegate;
- (id)initWithSuperFrame:(CGRect)superFrame theDelegate:(id<jotAutographViewDelegate>)delegate theSize:(CGSize) inputSize andTitle:(NSString *) price;
-(void)redrawWithNewFrame:(CGRect)newFrame;
@end
