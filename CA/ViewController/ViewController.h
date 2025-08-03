//
//  ViewController.h
//  ViewController
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "../Elements/Elements.h"
#import <GameplayKit/GameplayKit.h>
#import <UIKit/UIKit.h>

#define RECT(...) CGRectMake(__VA_ARGS__)

#define TSTRING(S) _l.string = (S)
#define TFONT(F) _f = (F)
#define TFONT_SIZE(S) _l.fontSize = (S)
#define TCOLOR(COLOR) _l.foregroundColor = (COLOR)
#define TALIGN(ALIGN) _l.alignmentMode = (ALIGN)

#define TA(E) (E.frame.origin.y)
#define LA(E) (E.frame.origin.x)
#define RA(E) (E.frame.origin.x + E.frame.size.width)
#define BA(E) (E.frame.origin.y + E.frame.size.height)

#define L(L) L.frame.origin.x
#define T(T) T.frame.origin.y
#define W(W) W.frame.size.width
#define H(H) H.frame.size.height

#define P(E, P) L(E) + P, T(E) + P, W(E) - P * 2, H(E) - P * 2
#define LEFT_FLEX(E, P)                                                        \
    L(E) + P, T(E) + P, (W(E) - P * 2) / 2 - P / 2, H(E) - P * 2
#define RIGHT_FLEX(E, P)                                                       \
    L(E) + W(E) / 2 + P / 2, T(E) + P, (W(E) - P * 2) / 2 - P / 2, H(E) - P * 2
#define FRAC_FLEX(LEAD, TOP, WID, HEI, PAD, SPT) LEAD, TOP, (W(WID) - PAD * (SPT - 1)) / SPT, HEI)

#define CENTER_IN(ELM, WID, HEI)                                               \
    L(ELM) + ((W(ELM) - WID) / 2), T(ELM) + ((H(ELM) - HEI) / 2), WID, HEI
#define CENTER_Y(E, S) TA(E) + (H(E) - S) / 2
#define CENTER_LEFT(ELM, W, H, P) LA(ELM) + P, CENTER_Y(ELM, H), W, H
#define CENTER_RIGHT(ELM, W, H, P) RA(ELM) - W - P, CENTER_Y(ELM, H), W, H
#define CENTER_BETWEEN(LEFT, RIGHT, IN, H, P)                                  \
    RA(LEFT) + P, CENTER_Y(IN, H), W_IN(LEFT, RIGHT, P), H

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

#define W_IN(LEFT, RIGHT, P) (LA(RIGHT) - RA(LEFT) - P * 2)

#define LAYER(RECT, ...)                                                       \
    ({                                                                         \
        CALayer *_l = [CALayer new];                                           \
        _l.frame = RECT;                                                       \
        __VA_ARGS__;                                                           \
        _l;                                                                    \
    })

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
        _l;                                                                    \
    })

#define COLOR(C) [UIColor C].CGColor
#define BG(C) _l.backgroundColor = C
#define OPACITY(O) _l.opacity = O

#define RADIUS(R)                                                              \
    _l.masksToBounds = true;                                                   \
    _l.cornerRadius = R
#define BORDER(W, C)                                                           \
    _l.borderWidth = W;                                                        \
    _l.borderColor = C
#define IMG(IMG) _l.contents = (__bridge id)[UIImage IMG].CGImage

#define RECOGNIZER                                                             \
    -(void)tapHandler : (UITapGestureRecognizer *)recognizer {                 \
        if (recognizer.state == UIGestureRecognizerStateEnded) {               \
            GesturePayload payload = {                                         \
                .cmd = G_TAP,                                                  \
                .tap = {.location = [recognizer locationInView:self.view]}};   \
            [self perform:payload];                                            \
        }                                                                      \
    }                                                                          \
                                                                               \
    -(void)doubleTapHandler : (UITapGestureRecognizer *)recognizer {           \
        if (recognizer.state == UIGestureRecognizerStateEnded) {               \
            GesturePayload payload = {                                         \
                .cmd = G_DOUBLE_TAP,                                           \
                .tap = {.location = [recognizer locationInView:self.view]}};   \
            [self perform:payload];                                            \
        }                                                                      \
    }                                                                          \
                                                                               \
    -(void)pressHandler : (UILongPressGestureRecognizer *)recognizer {         \
        if (recognizer.state == UIGestureRecognizerStateBegan) {               \
            GesturePayload payload = {                                         \
                .cmd = G_PRESS,                                                \
                .press = {.location = [recognizer locationInView:self.view]}}; \
            [self perform:payload];                                            \
        }                                                                      \
    }                                                                          \
                                                                               \
    -(void)panHandler : (UIPanGestureRecognizer *)recognizer {                 \
        if (recognizer.state == UIGestureRecognizerStateChanged ||             \
            recognizer.state == UIGestureRecognizerStateEnded) {               \
            GesturePayload payload = {                                         \
                .cmd = G_PAN,                                                  \
                .pan = {.translation =                                         \
                            [recognizer translationInView:self.view],          \
                        .velocity = [recognizer velocityInView:self.view],     \
                        .location = [recognizer locationInView:self.view]}};   \
            [self perform:payload];                                            \
        }                                                                      \
    }                                                                          \
                                                                               \
    -(void)pinchHandler : (UIPinchGestureRecognizer *)recognizer {             \
        if (recognizer.state == UIGestureRecognizerStateChanged ||             \
            recognizer.state == UIGestureRecognizerStateEnded) {               \
            GesturePayload payload = {                                         \
                .cmd = G_PINCH,                                                \
                .pinch = {.scale = recognizer.scale,                           \
                          .location = [recognizer locationInView:self.view]}}; \
            [self perform:payload];                                            \
        }                                                                      \
    }                                                                          \
                                                                               \
    -(void)rotationHandler : (UIRotationGestureRecognizer *)recognizer {       \
        if (recognizer.state == UIGestureRecognizerStateChanged ||             \
            recognizer.state == UIGestureRecognizerStateEnded) {               \
            GesturePayload payload = {                                         \
                .cmd = G_ROTATE,                                               \
                .rotate = {.rotation = recognizer.rotation,                    \
                           .location =                                         \
                               [recognizer locationInView:self.view]}};        \
            [self perform:payload];                                            \
        }                                                                      \
    }                                                                          \
                                                                               \
    -(void)swipeHandler : (UISwipeGestureRecognizer *)recognizer {             \
        Command cmd = G_NONE;                                                  \
        switch (recognizer.direction) {                                        \
        case UISwipeGestureRecognizerDirectionLeft:                            \
            cmd = G_SWIPE_LEFT;                                                \
            break;                                                             \
        case UISwipeGestureRecognizerDirectionRight:                           \
            cmd = G_SWIPE_RIGHT;                                               \
            break;                                                             \
        case UISwipeGestureRecognizerDirectionUp:                              \
            cmd = G_SWIPE_UP;                                                  \
            break;                                                             \
        case UISwipeGestureRecognizerDirectionDown:                            \
            cmd = G_SWIPE_DOWN;                                                \
            break;                                                             \
        default:                                                               \
            return;                                                            \
        }                                                                      \
                                                                               \
        GesturePayload payload = {                                             \
            .cmd = cmd,                                                        \
            .swipe = {.location = [recognizer locationInView:self.view]}};     \
        [self perform:payload];                                                \
    }                                                                          \
                                                                               \
    BOOL PointInsideLayer(CALayer *layer, CGPoint globalPoint) {               \
        CGPoint local = [layer convertPoint:globalPoint                        \
                                  fromLayer:layer.superlayer];                 \
        return CGRectContainsPoint(layer.bounds, local);                       \
    }

#define RECOGNIZERS(LONG_PRESS_DURATION, TAPS_REQUIRED)                        \
    /* Long Press */                                                           \
    UILongPressGestureRecognizer *pressGestureRecognizer =                     \
        [[UILongPressGestureRecognizer alloc]                                  \
            initWithTarget:self                                                \
                    action:@selector(pressHandler:)];                          \
    pressGestureRecognizer.minimumPressDuration = LONG_PRESS_DURATION;         \
    [self.view addGestureRecognizer:pressGestureRecognizer];                   \
                                                                               \
    /* Tap */                                                                  \
    UITapGestureRecognizer *tapGestureRecognizer =                             \
        [[UITapGestureRecognizer alloc]                                        \
            initWithTarget:self                                                \
                    action:@selector(tapHandler:)];                            \
    [tapGestureRecognizer                                                      \
        requireGestureRecognizerToFail:pressGestureRecognizer];                \
    [self.view addGestureRecognizer:tapGestureRecognizer];                     \
                                                                               \
    /* Double Tap */                                                           \
    UITapGestureRecognizer *doubleTapGestureRecognizer =                       \
        [[UITapGestureRecognizer alloc]                                        \
            initWithTarget:self                                                \
                    action:@selector(doubleTapHandler:)];                      \
    doubleTapGestureRecognizer.numberOfTapsRequired = TAPS_REQUIRED;           \
    [tapGestureRecognizer                                                      \
        requireGestureRecognizerToFail:doubleTapGestureRecognizer];            \
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];               \
                                                                               \
    /* Pan */                                                                  \
    UIPanGestureRecognizer *panGestureRecognizer =                             \
        [[UIPanGestureRecognizer alloc]                                        \
            initWithTarget:self                                                \
                    action:@selector(panHandler:)];                            \
    [self.view addGestureRecognizer:panGestureRecognizer];                     \
                                                                               \
    /* Swipe Right */                                                          \
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]   \
        initWithTarget:self                                                    \
                action:@selector(swipeHandler:)];                              \
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;             \
    [self.view addGestureRecognizer:swipeRight];                               \
    [panGestureRecognizer requireGestureRecognizerToFail:swipeRight];          \
                                                                               \
    /* Swipe Left */                                                           \
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]    \
        initWithTarget:self                                                    \
                action:@selector(swipeHandler:)];                              \
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;               \
    [self.view addGestureRecognizer:swipeLeft];                                \
    [panGestureRecognizer requireGestureRecognizerToFail:swipeLeft];           \
                                                                               \
    /* Swipe Up */                                                             \
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]      \
        initWithTarget:self                                                    \
                action:@selector(swipeHandler:)];                              \
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;                   \
    [self.view addGestureRecognizer:swipeUp];                                  \
    [panGestureRecognizer requireGestureRecognizerToFail:swipeUp];             \
                                                                               \
    /* Swipe Down */                                                           \
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]    \
        initWithTarget:self                                                    \
                action:@selector(swipeHandler:)];                              \
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;               \
    [self.view addGestureRecognizer:swipeDown];                                \
    [panGestureRecognizer requireGestureRecognizerToFail:swipeDown];           \
                                                                               \
    /* Pinch */                                                                \
    UIPinchGestureRecognizer *pinchGestureRecognizer =                         \
        [[UIPinchGestureRecognizer alloc]                                      \
            initWithTarget:self                                                \
                    action:@selector(pinchHandler:)];                          \
    [self.view addGestureRecognizer:pinchGestureRecognizer];                   \
                                                                               \
    /* Rotation */                                                             \
    UIRotationGestureRecognizer *rotationGestureRecognizer =                   \
        [[UIRotationGestureRecognizer alloc]                                   \
            initWithTarget:self                                                \
                    action:@selector(rotationHandler:)];                       \
    [self.view addGestureRecognizer:rotationGestureRecognizer];                \
                                                                               \
    [pinchGestureRecognizer                                                    \
        requireGestureRecognizerToFail:panGestureRecognizer];

typedef enum {
    G_NONE,
    G_TAP,
    G_DOUBLE_TAP,
    G_PRESS,
    G_PAN,
    G_PINCH,
    G_ROTATE,
    G_SWIPE_LEFT,
    G_SWIPE_RIGHT,
    G_SWIPE_UP,
    G_SWIPE_DOWN
} Command;

typedef struct {
    Command cmd;

    union {
        struct Tap {
            CGPoint location;
        } tap;

        struct Press {
            CGPoint location;
        } press;

        struct Pan {
            CGPoint translation;
            CGPoint velocity;
            CGPoint location;
        } pan;

        struct Pinch {
            CGFloat scale;
            CGPoint location;
        } pinch;

        struct Rotate {
            CGFloat rotation;
            CGPoint location;
        } rotate;

        struct Swipe {
            CGPoint location;
        } swipe;
    };
} GesturePayload;

@interface ViewController : UIViewController
@end
