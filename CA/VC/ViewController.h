//
//  ViewController.h
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import <UIKit/UIKit.h>

#define A(R)        (R.origin.x)
#define B(R)        (R.origin.y)
#define C(R)        (R.origin.x + R.size.width)
#define D(R)        (R.origin.y + R.size.height)
#define WIDTH(R)    (C(R) - A(R))
#define HEIGHT(R)   (D(R) - B(R))

// Layout

#define COLOR(X) [UIColor X].CGColor
#define R(X, Y, W, H) CGRectMake(X, Y, W, H)

#define EXPAND(...) __VA_ARGS__
#define COMMA_SAFE(...) EXPAND(__VA_ARGS__)

#define SPACER
#define LAYER1(NAME, ARG) NAME.ARG
#define LAYER2(NAME, ARG, ARG2) NAME.ARG NAME.ARG2
#define LAYER3(NAME, ARG, ARG2, ARG3) NAME.ARG NAME.ARG2 NAME.ARG3
#define LAYER4(NAME, ARG, ARG2, ARG3, ARG4)                                    \
    NAME.ARG NAME.ARG2 NAME.ARG3 NAME.ARG4
#define LAYER5(NAME, ARG, ARG2, ARG3, ARG4, ARG5)                              \
    NAME.ARG NAME.ARG2 NAME.ARG3 NAME.ARG4 NAME.ARG5

#define GET_MACRO(_1, _2, _3, _4, _5, _6, x, ...) x
#define ROUTER(...)                                                            \
    GET_MACRO(__VA_ARGS__, LAYER5, LAYER4, LAYER3, LAYER2, LAYER1,             \
              SPACER)(__VA_ARGS__)

#define LAYER(NAME, RECT, ...)                                                 \
    CALayer *NAME = [CALayer new];                                             \
    COMMA_SAFE(ROUTER(NAME, ##__VA_ARGS__));                                   \
    NAME.masksToBounds = true;                                                 \
    NAME.frame = RECT;                                                         \
    [self.view.layer addSublayer:NAME];

#define BACKGROUND(X) backgroundColor = X;
#define RADIUS(X) cornerRadius = X;
#define OPACITY(X) opacity = 0.2;
#define BORDER_COLOR(X) borderColor = X;
#define BORDER_WIDTH(X) borderWidth = X;

@interface ViewController : UIViewController
@end
