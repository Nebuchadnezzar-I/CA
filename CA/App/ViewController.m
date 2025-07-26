//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

#define ADD_DEBUG_LAYOUT_LAYER 1

#if ADD_DEBUG_LAYOUT_LAYER

#define LAYOUT(X, Y, W, H)                                                     \
    ({                                                                         \
        Layout _layout = {.x = (X), .y = (Y), .w = (W), .h = (H)};             \
        CA(_layout);                                                           \
        _layout;                                                               \
    })

#else

#define LAYOUT(X, Y, W, H)                                                     \
    (Layout) { .x = (X), .y = (Y), .w = (W), .h = (H) }

#endif

#define CA(LAYOUT)                                                             \
    do {                                                                       \
        CALayer *layer = [CALayer new];                                        \
        layer.frame = CGRectMake(LAYOUT.x, LAYOUT.y, LAYOUT.w, LAYOUT.h);      \
        layer.backgroundColor = [ViewController randomColor].CGColor;          \
        [self.view.layer addSublayer:layer];                                   \
    } while (0)

//      Width Padded
#define WIDTH_PADDED(PAR, PAD) PAR.w - 2 * PAD
#define TOP 56

#define LEADING(LAYOUT) LAYOUT.x
#define TRAILING(LAYOUT, SIZE, PAD) sw - LAYOUT.x - SIZE - PAD
#define W(LAYOUT) LAYOUT.w
#define H(LAYOUT) LAYOUT.h

//      Horizontal Centered Top val
#define HC_TOP(LAYOUT, SIZE) (LAYOUT.h - SIZE) / 2 + LAYOUT.y

#define ELM_TOP(ELM) ELM.y + ELM.h

typedef struct {
    CGFloat x;
    CGFloat y;
    CGFloat w;
    CGFloat h;
} Layout;

@interface ViewController () {
    NSMutableDictionary *layers;
    CGFloat sw, sh;
}
@end

@implementation ViewController

- (void)app {
    Layout container = LAYOUT(0, TOP, sw, sh - TOP);

    Layout header_layout =
        LAYOUT(16, container.y, WIDTH_PADDED(container, 16), 64);

    Layout left_icon =
        LAYOUT(LEADING(header_layout) + 8, HC_TOP(header_layout, 48), 48, 48);

    Layout right_icon = LAYOUT(
        TRAILING(header_layout, 48, 8),
        HC_TOP(header_layout, 48), 48, 48);

    Layout big_box =
        LAYOUT(16, ELM_TOP(header_layout) + 16,
               WIDTH_PADDED(container, 16),
               container.h - (header_layout.h + 16 + 16));
}

+ (UIColor *)randomColor {
    return [UIColor colorWithHue:(arc4random_uniform(256) / 255.0)
                      saturation:0.85
                      brightness:0.95
                           alpha:1.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];

    sw = [UIScreen mainScreen].bounds.size.width;
    sh = [UIScreen mainScreen].bounds.size.height;

    [self app];
}

@end
