//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

// CS = Coordination Space
// Defines size of grid window (8, 16, 24, 32 etc.)
#define CS 8
#define CS_X (SW - floor(SW / CS) * CS) / 2
#define CS_Y (SH - floor(SH / CS) * CS) / 2
#define CS_W floor(SW / CS) * CS
#define CS_H floor(SH / CS) * CS

#define CS_T(L) (L.frame.origin.y)
#define CS_R(L) (L.frame.size.width + L.frame.origin.x)
#define CS_B(L) (L.frame.size.height + L.frame.origin.y)
#define CS_L(L) (L.frame.origin.x)

#define CS_IN(W, X, P) W - 2 * (X + P)

@interface ViewController () {
    CGFloat SW, SH;
}
@end

@implementation ViewController

- (void)ui {
    [self layer:CGRectMake(CS_X, CS_Y, CS_W, CS_H)
        background:[UIColor grayColor]];

    // Left floating button
    CALayer *_blackTop =
    [self layer:CGRectMake(CS_X + 16, CS_Y + 64, CS_IN(CS_W, CS_X, 16), 64)
        background:[UIColor blackColor]];
    
    CGFloat rectWidth = (CS_W - 2 * (CS_X + 16)) / 2 - 4;
    
    CALayer *_blackLeft =
    [self layer:CGRectMake(CS_X + 16, CS_B(_blackTop) + 8, rectWidth, 64)
        background:[UIColor blackColor]];
    
    [self layer:CGRectMake(CS_R(_blackLeft) + 8, CS_B(_blackTop) + 8, rectWidth, 64)
        background:[UIColor blackColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    SW = [UIScreen mainScreen].bounds.size.width;
    SH = [UIScreen mainScreen].bounds.size.height;
    self.view.backgroundColor = [UIColor redColor];
    [self ui];
}

- (CALayer *)layer:(CGRect)frame background:(UIColor *)background {
    CALayer *_l = [CALayer new];
    _l.frame = frame;
    _l.backgroundColor = background.CGColor;
    [self.view.layer addSublayer:_l];
    return _l;
}

@end
