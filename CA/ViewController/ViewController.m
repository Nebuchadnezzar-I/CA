//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

typedef enum { HEADER, SOME_TEXT } Layers;

@interface ViewController () {
    NSMutableDictionary *layers;
    CGFloat SW, SH;
}
@end

#define LAYER(NAME, RECT, ...)                                                 \
    do {                                                                       \
        CALayer *_l = [CALayer new];                                           \
        _l.frame = RECT;                                                       \
        __VA_ARGS__;                                                           \
        layers[@(NAME)] = _l;                                                  \
    } while (0)

#define TEXT(NAME, RECT, ...)                                                  \
    do {                                                                       \
        CATextLayer *_l = [CATextLayer new];                                   \
        _l.frame = RECT;                                                       \
        _l.contentsScale = UIScreen.mainScreen.scale;                          \
        __VA_ARGS__;                                                           \
        layers[@(NAME)] = _l;                                                  \
    } while (0)

#define SCROLL()

// Modifiers
#define CG_COLOR(VAL) [UIColor VAL].CGColor

#define FW_ULTRALIGHT UIFontWeightUltraLight
#define FW_THIN UIFontWeightThin
#define FW_LIGHT UIFontWeightLight
#define FW_REGULAR UIFontWeightRegular
#define FW_MEDIUM UIFontWeightMedium
#define FW_SEMIBOLD UIFontWeightSemibold
#define FW_BOLD UIFontWeightBold
#define FW_HEAVY UIFontWeightHeavy
#define FW_BLACK UIFontWeightBlack

#define ALIGN_LEFT kCAAlignmentLeft

//

#define RADIUS(VAL) _l.cornerRadius = VAL
#define BACKGROUND(VAL) _l.backgroundColor = VAL
#define STRING(VAL) _l.string = VAL
#define ALIGNMENT(VAL) _l.alignmentMode = VAL
#define FONT(SIZE, WEIGHT) \
    (_l.font = CGFontCreateWithFontName((CFStringRef)[UIFont systemFontOfSize:SIZE weight:WEIGHT].fontName), \
     _l.fontSize = SIZE)

@implementation ViewController

- (void)ui {
    LAYER(HEADER, [Elements TX:16 TY:72 BX:SW - 16 BY:136], RADIUS(32),
          BACKGROUND(CG_COLOR(blueColor)));

    TEXT(SOME_TEXT, [Elements X:16 Y:136 W:SW - 32 H:24],
         STRING(@"Hello World!"), FONT(20, FW_REGULAR), ALIGNMENT(ALIGN_LEFT));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];
    layers = [[NSMutableDictionary alloc] initWithCapacity:8];
    SW = [UIScreen mainScreen].bounds.size.width;
    SH = [UIScreen mainScreen].bounds.size.height;

    HIDE_HEADER();

    [self ui];

    for (CALayer *_l in [layers allValues]) {
        [self.view.layer addSublayer:_l];
    }
}

@end
