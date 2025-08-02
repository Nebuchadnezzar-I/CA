//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

//
// Recognizers
//

#define SWIPE_DIR_RIGHT UISwipeGestureRecognizerDirectionRight
#define SWIPE_DIR_LEFT  UISwipeGestureRecognizerDirectionLeft
#define SWIPE_DIR_UP    UISwipeGestureRecognizerDirectionUp
#define SWIPE_DIR_DOWN  UISwipeGestureRecognizerDirectionDown

#define RECOGNIZER(LONG_PRESS_DURATION, TAPS_REQUIRED)                         \
    /* Long Press */                                                           \
    UILongPressGestureRecognizer *pressGestureRecognizer =                     \
        [[UILongPressGestureRecognizer alloc]                                  \
            initWithTarget:self action:@selector(pressHandler:)];              \
    pressGestureRecognizer.minimumPressDuration = LONG_PRESS_DURATION;         \
    [self.view addGestureRecognizer:pressGestureRecognizer];                   \
                                                                               \
    /* Tap */                                                                  \
    UITapGestureRecognizer *tapGestureRecognizer =                             \
        [[UITapGestureRecognizer alloc]                                        \
            initWithTarget:self action:@selector(tapHandler:)];                \
    [tapGestureRecognizer requireGestureRecognizerToFail:pressGestureRecognizer]; \
    [self.view addGestureRecognizer:tapGestureRecognizer];                     \
                                                                               \
    /* Double Tap */                                                           \
    UITapGestureRecognizer *doubleTapGestureRecognizer =                       \
        [[UITapGestureRecognizer alloc]                                        \
            initWithTarget:self action:@selector(doubleTapHandler:)];          \
    doubleTapGestureRecognizer.numberOfTapsRequired = TAPS_REQUIRED;           \
    [tapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer]; \
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];               \
                                                                               \
    /* Pan */                                                                  \
    UIPanGestureRecognizer *panGestureRecognizer =                             \
        [[UIPanGestureRecognizer alloc]                                        \
            initWithTarget:self action:@selector(panHandler:)];                \
    [self.view addGestureRecognizer:panGestureRecognizer];                     \
                                                                               \
    /* Swipe Right */                                                          \
    UISwipeGestureRecognizer *swipeRight =                                     \
        [[UISwipeGestureRecognizer alloc]                                      \
            initWithTarget:self action:@selector(swipeHandler:)];              \
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;             \
    [self.view addGestureRecognizer:swipeRight];                               \
    [panGestureRecognizer requireGestureRecognizerToFail:swipeRight];          \
                                                                               \
    /* Swipe Left */                                                           \
    UISwipeGestureRecognizer *swipeLeft =                                      \
        [[UISwipeGestureRecognizer alloc]                                      \
            initWithTarget:self action:@selector(swipeHandler:)];              \
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;               \
    [self.view addGestureRecognizer:swipeLeft];                                \
    [panGestureRecognizer requireGestureRecognizerToFail:swipeLeft];           \
                                                                               \
    /* Swipe Up */                                                             \
    UISwipeGestureRecognizer *swipeUp =                                        \
        [[UISwipeGestureRecognizer alloc]                                      \
            initWithTarget:self action:@selector(swipeHandler:)];              \
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;                   \
    [self.view addGestureRecognizer:swipeUp];                                  \
    [panGestureRecognizer requireGestureRecognizerToFail:swipeUp];             \
                                                                               \
    /* Swipe Down */                                                           \
    UISwipeGestureRecognizer *swipeDown =                                      \
        [[UISwipeGestureRecognizer alloc]                                      \
            initWithTarget:self action:@selector(swipeHandler:)];              \
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;               \
    [self.view addGestureRecognizer:swipeDown];                                \
    [panGestureRecognizer requireGestureRecognizerToFail:swipeDown];           \
                                                                               \
    /* Pinch */                                                                \
    UIPinchGestureRecognizer *pinchGestureRecognizer =                         \
        [[UIPinchGestureRecognizer alloc]                                      \
            initWithTarget:self action:@selector(pinchHandler:)];              \
    [self.view addGestureRecognizer:pinchGestureRecognizer];                   \
                                                                               \
    /* Rotation */                                                             \
    UIRotationGestureRecognizer *rotationGestureRecognizer =                   \
        [[UIRotationGestureRecognizer alloc]                                   \
            initWithTarget:self action:@selector(rotationHandler:)];           \
    [self.view addGestureRecognizer:rotationGestureRecognizer];                \
                                                                               \
    [pinchGestureRecognizer requireGestureRecognizerToFail:panGestureRecognizer];

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

#define BASE()                                                                 \
    CALayer *base = [CALayer new];                                             \
    base.frame = RECT(0, 0, sw, sh);

#define LAYER(NAME, RECT, ...)                                                 \
    do {                                                                       \
        CALayer *_l = [CALayer new];                                           \
        _l.frame = RECT;                                                       \
        __VA_ARGS__;                                                           \
        reg_layers[NAME] = _l;                                                 \
    } while (0)

#define TEXT(NAME, RECT, ...)                                                  \
    do {                                                                       \
        UIFont *_f = FONT(16, FW_LIGHT);                                       \
        CATextLayer *_l = [CATextLayer new];                                   \
        _l.frame = RECT;                                                       \
        _l.contentsScale = [UIScreen mainScreen].scale;                        \
        _l.string = nil;                                                       \
        _l.string = @"Remove this text!";                                      \
        _l.fontSize = _f.pointSize;                                            \
        __VA_ARGS__;                                                           \
        (__bridge CFTypeRef) _f;                                               \
        reg_layers[NAME] = _l;                                                 \
    } while (0)

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

typedef enum GestureType {
    TAP, DOUBLE_TAP, PRESS, PAN, PINCH, ROTATION,
    SWIPE_LEADING, SWIPE_TRAILING, SWIPE_TOP, SWIPE_BOTTOM
} GestureType;

typedef void (^AnimationBlock)(UIGestureRecognizer *inputValue);

typedef struct {
    AnimationBlock block;
    GestureType gesture;
    CALayer *layer;
} AnimationProps;

@interface ViewController () {
    CGFloat sw, sh;
    
    NSMutableDictionary *reg_animations;
    NSMutableDictionary *reg_layers;
}
@end

@implementation ViewController

- (void)ui {
    BASE();
    
    LAYER(@"Header", RECT(16, 72, sw - 32, 64),
          BG(COLOR(colorNamed : @"Component")),
          RADIUS(8));
    
    TEXT(@"Action", RECT(CENTER_IN(base, 300, FH(FONT(16, FW_LIGHT), 4))),
         TALIGN(kCAAlignmentCenter));
    
    AnimationProps *props = malloc(sizeof(AnimationProps));
    props->gesture = PRESS;
    props->layer = reg_layers[@"Header"];
    props->block = ^(id inputValue) {
        CALayer *_l = self->reg_layers[@"Header"];

        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        anim.fromValue = (__bridge id)COLOR(colorNamed: @"Component");
        anim.toValue   = (__bridge id)[UIColor blueColor].CGColor;

        [CATransaction begin];
        [CATransaction setAnimationDuration:0.5];

        [_l addAnimation:anim forKey:nil];
        _l.backgroundColor = [UIColor blueColor].CGColor;

        [CATransaction commit];
    };
    reg_animations[@"HeaderAnimation"] = [NSValue valueWithPointer:props];

    RECOGNIZER(3.0, 2);
}

- (void)tapHandler:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    
    for (NSValue *val in [reg_animations allValues]) {
        AnimationProps *props = [val pointerValue];
        if (CGRectContainsPoint(props->layer.frame, location)
            && props->gesture == TAP
        ) { props->block(nil); }
    }
}

- (void)doubleTapHandler:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    
    for (NSValue *val in [reg_animations allValues]) {
        AnimationProps *props = [val pointerValue];
        if (CGRectContainsPoint(props->layer.frame, location)
            && props->gesture == DOUBLE_TAP
        ) { props->block(nil); }
    }
}

- (void)pressHandler:(UILongPressGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    
    for (NSValue *val in [reg_animations allValues]) {
        AnimationProps *props = [val pointerValue];
        if (CGRectContainsPoint(props->layer.frame, location)
            && props->gesture == PRESS &&
            recognizer.state == UIGestureRecognizerStateBegan
        ) { props->block(nil); }
    }
}

- (void)panHandler:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    ((CATextLayer *)reg_layers[@"Action"]).string =
        (__bridge NSString *)CFStringCreateWithFormat(NULL, NULL, CFSTR("Pan: {%.1f, %.1f}"), translation.x, translation.y);
}

- (void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    NSString *msg = @"Unknown Swipe";
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight: msg = @"Swipe Right"; break;
        case UISwipeGestureRecognizerDirectionLeft:  msg = @"Swipe Left";  break;
        case UISwipeGestureRecognizerDirectionUp:    msg = @"Swipe Up";    break;
        case UISwipeGestureRecognizerDirectionDown:  msg = @"Swipe Down";  break;
    }
    ((CATextLayer *)reg_layers[@"Action"]).string = msg;
}

- (void)pinchHandler:(UIPinchGestureRecognizer *)recognizer {
    NSString *msg = [NSString stringWithFormat:@"Pinch scale: %.2f", recognizer.scale];
    ((CATextLayer *)reg_layers[@"Action"]).string = msg;
}

- (void)rotationHandler:(UIRotationGestureRecognizer *)recognizer {
    NSString *msg = [NSString stringWithFormat:@"Rotation: %.2f", recognizer.rotation];
    ((CATextLayer *)reg_layers[@"Action"]).string = msg;
}

//

- (void)mount {
    for (CALayer *layer in [reg_layers allValues]) {
        [self.view.layer addSublayer:layer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Background"];
    
    sw = [UIScreen mainScreen].bounds.size.width;
    sh = [UIScreen mainScreen].bounds.size.height;
    
    reg_layers = [[NSMutableDictionary alloc] initWithCapacity:4];
    reg_animations = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    [self ui];
    [self mount];
}

@end
