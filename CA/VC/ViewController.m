//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

//
// Layout Core
//

#define RECT(...) CGRectMake(__VA_ARGS__)

#define TA(E) (E.frame.origin.y)
#define LA(E) (E.frame.origin.x)
#define RA(E) (E.frame.origin.x + E.frame.size.width)
#define BA(E) (E.frame.origin.y + E.frame.size.height)

#define L(L) L.frame.origin.x
#define T(T) T.frame.origin.y
#define W(W) W.frame.size.width
#define H(H) H.frame.size.height

// Layout Extensions

#define P(E, P) L(E) + P, T(E) + P, W(E) - P * 2, H(E) - P * 2
#define LEFT_FLEX(E, P) L(E) + P, T(E) + P, (W(E) - P * 2) / 2 - P / 2, H(E) - P * 2
#define RIGHT_FLEX(E, P) L(E) + W(E) / 2 + P / 2, T(E) + P, (W(E) - P * 2) / 2 - P / 2, H(E) - P * 2
#define FRAC_FLEX(LEAD, TOP, WID, HEI, PAD, SPT) LEAD, TOP, (W(WID) - PAD * (SPT - 1)) / SPT, HEI)

#define CENTER_IN(ELM, WID, HEI) L(ELM) + ((W(ELM) - WID) / 2), T(ELM) + ((H(ELM) - HEI) / 2), WID, HEI
#define CENTER_Y(E, S) TA(E) + (H(E) - S) / 2
#define CENTER_LEFT(ELM, W, H, P) LA(ELM) + P, CENTER_Y(ELM, H), W, H
#define CENTER_RIGHT(ELM, W, H, P) RA(ELM) - W - P, CENTER_Y(ELM, H), W, H
#define CENTER_BETWEEN(LEFT, RIGHT, IN, H, P) RA(LEFT) + P, CENTER_Y(IN, H), W_IN(LEFT, right_icon, P), H

#define W_IN(LEFT, RIGHT, P) (LA(RIGHT) - RA(LEFT) - P * 2)

//
// Layer Core
//

#define LAYER(RECT, ...)                                                       \
    ({                                                                         \
        CALayer *_l = [CALayer new];                                           \
        _l.frame = RECT;                                                       \
        __VA_ARGS__;                                                           \
        [self.view.layer addSublayer:_l];                                      \
        _l;                                                                    \
    });

//
// Modifers
//

#define COLOR(C) [UIColor C].CGColor
#define BG(C) _l.backgroundColor = C
#define RADIUS(R)                                                              \
    _l.masksToBounds = true;                                                   \
    _l.cornerRadius = R
#define BORDER(W, C)                                                           \
    _l.borderWidth = W;                                                        \
    _l.borderColor = C
#define IMG(IMG)                                                               \
    _l.contents = (__bridge id)[UIImage IMG].CGImage

@interface ViewController () {
    CGFloat sw, sh;
}
@end

@implementation ViewController

- (void)render {
    //
    CALayer *header =
    LAYER(RECT(16, 72, sw - 32, 64),
          BG(COLOR(colorNamed : @"Component")), RADIUS(32));
    
    LAYER(RECT(CENTER_LEFT(header, 20, 20, 24)),
          BG(COLOR(redColor)));
    
    //
    CALayer *left_icon =
    LAYER(RECT(CENTER_LEFT(header, 48, 48, 8)),
          BG(COLOR(blueColor)), RADIUS(24));
    
    LAYER(RECT(CENTER_IN(left_icon, 20, 20)),
          IMG(imageNamed:@"Search"));

    //
    CALayer *right_icon =
    LAYER(RECT(CENTER_RIGHT(header, 48, 48, 8)),
          BG(COLOR(blueColor)), RADIUS(24));
    
    LAYER(RECT(CENTER_IN(right_icon, 22, 18)),
          IMG(imageNamed:@"Options"));
 
    LAYER(RECT(CENTER_BETWEEN(left_icon, right_icon, header, 20, 4)),
          BG(COLOR(redColor)))

    //    CALayer *redRect =
    //        LAYER(RECT(16, 72, sw - 32, 64));
    //
    //    LAYER(RECT(LEFT_FLEX(redRect, 4)));
    //
    //    CALayer *yellowRect =
    //    [self layerWithFrame:[UIColor yellowColor]
    //                   frame:CGRectMake(RIGHT_FLEX(redRect, 4))];
    //
    //    [self layerWithFrame:[UIColor brownColor]
    //                   frame:CGRectMake(CENTER_IN(yellowRect, 64, 24)];
    //
    //    CALayer *pinkRect =
    //    [self layerWithFrame:[UIColor systemPinkColor]
    //                   frame:CGRectMake(LA(redRect), BA(redRect) + 16,
    //                   W(redRect), 100)];
    //
    //    // Flex
    //    CALayer *flexRect =
    //    [self layerWithFrame:[UIColor systemPinkColor]
    //                   frame:CGRectMake(FRAC_FLEX(LA(redRect), BA(pinkRect) +
    //                   8, redRect, 100, 8, 2)];
    //
    //    [self layerWithFrame:[UIColor systemPinkColor]
    //                   frame:CGRectMake(FRAC_FLEX(RA(flexRect) + 8,
    //                   BA(pinkRect) + 8, redRect, 100, 8, 2)];
    //
    //    // Flex frac
    //    CALayer *frac1 =
    //    [self layerWithFrame:[UIColor systemPinkColor]
    //                   frame:CGRectMake(FRAC_FLEX(LA(redRect), BA(flexRect) +
    //                   8, redRect, 100, 8, 3)];
    //
    //    CALayer *frac2 =
    //    [self layerWithFrame:[UIColor systemPinkColor]
    //                   frame:CGRectMake(FRAC_FLEX(RA(frac1) + 8, BA(flexRect)
    //                   + 8, redRect, 100, 8, 3)];
    //
    //    [self layerWithFrame:[UIColor systemPinkColor]
    //                   frame:CGRectMake(FRAC_FLEX(RA(frac2) + 8, BA(flexRect)
    //                   + 8, redRect, 100, 8, 3)];
}

- (CALayer *)newLayer:(CGRect)frame {
    CALayer *l = [CALayer new];
    l.frame = frame;
    [self.view.layer addSublayer:l];
    return l;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];

    sw = [UIScreen mainScreen].bounds.size.width;
    sh = [UIScreen mainScreen].bounds.size.height;

    [self render];
}

@end
