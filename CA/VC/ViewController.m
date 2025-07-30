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

// Layer
#define TA(E) (E.frame.origin.y)
#define LA(E) (E.frame.origin.x)
#define RA(E) (E.frame.origin.x + E.frame.size.width)
#define BA(E) (E.frame.origin.y + E.frame.size.height)

#define L(L) L.frame.origin.x
#define T(T) T.frame.origin.y
#define W(W) W.frame.size.width
#define H(H) H.frame.size.height

// Font (Font, Offset)
#define FH(F, O) (F.pointSize + O)

#define FONT(S, W) ({ [UIFont systemFontOfSize:S weight:W]; })

#define FW_ULTRA_LIGHT  UIFontWeightUltraLight
#define FW_THIN         UIFontWeightThin
#define FW_LIGHT        UIFontWeightLight
#define FW_REGULAR      UIFontWeightRegular
#define FW_MEDIUM       UIFontWeightMedium
#define FW_SEMIBOLD     UIFontWeightSemibold
#define FW_BOLD         UIFontWeightBold
#define FW_HEAVY        UIFontWeightHeavy
#define FW_BLACK        UIFontWeightBlack

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

#define TEXT(RECT, ...)                                                        \
    ({                                                                         \
        UIFont *_f = FONT(16, FW_LIGHT);                                       \
        CATextLayer *_l = [CATextLayer new];                                   \
        _l.frame = RECT;                                                       \
        _l.contentsScale = [UIScreen mainScreen].scale;                        \
        _l.string = nil;                                                       \
        _l.string = @"Remove this text!";                                      \
        _l.fontSize = _f.pointSize;                                            \
        __VA_ARGS__;                                                           \
        (__bridge CFTypeRef) _f;                                               \
        [self.view.layer addSublayer:_l];                                      \
    });

//
// Modifers
//

#define TSTRING(S)        _l.string = (S)
#define TFONT(F)          _f = (F)
#define TFONT_SIZE(S)     _l.fontSize = (S)
#define TCOLOR(COLOR)     _l.foregroundColor = (COLOR)
#define TALIGN(ALIGN)     _l.alignmentMode = (ALIGN)

#define COLOR(C) [UIColor C].CGColor
#define BG(C) _l.backgroundColor = C
#define OPACITY(O) _l.opacity = O

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
@property (nonatomic, strong) CALayer *leftIconLayer;
@property (nonatomic, strong) CALayer *leftIcon;
@end

@implementation ViewController

- (void)render {
    CALayer *header =
    LAYER(RECT(16, 72, sw - 32, 64),
          BG(COLOR(colorNamed : @"Component")), RADIUS(32));

    
    //
    self.leftIconLayer =
    LAYER(RECT(CENTER_LEFT(header, 48, 48, 8)),
          RADIUS(24));
    self.leftIcon =
    LAYER(RECT(CENTER_IN(self.leftIconLayer, 20, 20)),
          IMG(imageNamed:@"Search"));
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    //
    
    CALayer *right_icon =
    LAYER(RECT(CENTER_RIGHT(header, 48, 48, 8)),
          BG(COLOR(colorNamed:@"Secondary")), RADIUS(24));
    
    LAYER(RECT(CENTER_IN(right_icon, 22, 18)),
          IMG(imageNamed:@"Options"));


    TEXT(RECT(CENTER_BETWEEN(self.leftIconLayer, right_icon, header, 18, 8)),
         TFONT_SIZE(16),
         TCOLOR(COLOR(whiteColor)));
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self.view];
    CALayer *hitLayer = [self.view.layer hitTest:point];

    if (hitLayer == self.leftIcon || hitLayer == self.leftIconLayer) {
        NSLog(@"Tapped myLayer!");
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.1];
        self.leftIconLayer.backgroundColor = COLOR(colorNamed:@"Secondary");
        [CATransaction commit];
        
        return;
    }
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.2];
    self.leftIconLayer.backgroundColor = COLOR(clearColor);
    [CATransaction commit];
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
