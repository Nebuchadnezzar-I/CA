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

@interface ViewController () { CGFloat sw, sh; }
@property (nonatomic) BOOL didTriggerLongPress;
@property (nonatomic, strong) CALayer *header;
@end

@implementation ViewController

- (void)render {
    self.header = LAYER(RECT(16, 72, sw - 32, 64),
                        BG(COLOR(colorNamed : @"Component")),
                        RADIUS(32));
    
    // Long Press
    UILongPressGestureRecognizer *pressGestureRecognizer =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressHandler:)];
    pressGestureRecognizer.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:pressGestureRecognizer];

    // Tap
    UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    [tapGestureRecognizer requireGestureRecognizerToFail:pressGestureRecognizer]; // prevent conflict
    [self.view addGestureRecognizer:tapGestureRecognizer];

    // Double Tap
    UITapGestureRecognizer *doubleTapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapHandler:)];
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [tapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];

    [tapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    [tapGestureRecognizer requireGestureRecognizerToFail:pressGestureRecognizer];
    
    // Pan (drag)
    UIPanGestureRecognizer *panGestureRecognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:panGestureRecognizer];

    // Swipe (can specify direction)
    UISwipeGestureRecognizer *swipeGestureRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    [panGestureRecognizer requireGestureRecognizerToFail:swipeGestureRecognizer];

    // Pinch (zoom)
    UIPinchGestureRecognizer *pinchGestureRecognizer =
        [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchHandler:)];
    [self.view addGestureRecognizer:pinchGestureRecognizer];

    // Rotation
    UIRotationGestureRecognizer *rotationGestureRecognizer =
        [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationHandler:)];
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    
    [pinchGestureRecognizer requireGestureRecognizerToFail:swipeGestureRecognizer];
}

- (void)tapHandler:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Tap recognized");
}

- (void)doubleTapHandler:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Double Tap recognized");
}

- (void)pressHandler:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Long Press began");
    }
}

- (void)panHandler:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    NSLog(@"Pan translation: %@", NSStringFromCGPoint(translation));
}

- (void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe recognized");
}

- (void)pinchHandler:(UIPinchGestureRecognizer *)recognizer {
    NSLog(@"Pinch scale: %f", recognizer.scale);
}

- (void)rotationHandler:(UIRotationGestureRecognizer *)recognizer {
    NSLog(@"Rotation: %f", recognizer.rotation);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Background"];
    
    sw = [UIScreen mainScreen].bounds.size.width;
    sh = [UIScreen mainScreen].bounds.size.height;
    
    [self render];
}

@end
