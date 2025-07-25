//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

typedef struct {
    CGFloat x;
    CGFloat y;
    CGFloat h;
    CGFloat w;
} Layout;

#define LAYOUT(W, H, X, Y) {.x = X, .y = Y, .w = W, .h = H}

#define LAYER(NAME, LAYOUT, BG, CORNER) \
[self layerWithName:NAME frame:LAYOUT background:[UIColor colorNamed:BG] radius:CORNER]

#define ANCHOR_LEFT(LAYOUT, PAD) LAYOUT.x + PAD
#define ANCHOR_RIGHT(LAYOUT, WIDTH, PAD) \
sw - (sw - LAYOUT.w) / 2 - WIDTH - PAD

#define CENTER_VERT(PARENT, H) \
PARENT.y + (PARENT.h - H) / 2

@interface ViewController () {
    CGFloat sw, sh;
}
@end

@implementation ViewController

- (void)app {
    
    // Search
    Layout search_layout = LAYOUT(sw - 48, 64, 24, 72);
    CALayer *search =
        LAYER(@"Search", search_layout, @"Component", 32);
    
    // Search Icon
    Layout search_icon_layout = LAYOUT(32, 32,
           ANCHOR_LEFT(search_layout, 16),
           CENTER_VERT(search_layout, 32));
    
    CALayer *search_icon =
        LAYER(@"SearchIcon", search_icon_layout, @"Secondary", 16);
    
    // Options Icon
    Layout options_icon_layout = LAYOUT(32, 32,
           ANCHOR_RIGHT(search_layout, 32, 16),
           CENTER_VERT(search_layout, 32));
    
    CALayer *options_icon =
        LAYER(@"OptionsIcon", options_icon_layout, @"Secondary", 16);

    
    
    // Will use dict to store elements in DL
    [self.view.layer addSublayer:search];
    [self.view.layer addSublayer:search_icon];
    [self.view.layer addSublayer:options_icon];
}

- (CALayer *)layerWithName:(NSString *)name
                     frame:(Layout)frame
                background:(UIColor *)bg
                    radius:(CGFloat)radius {
    CALayer *newLayer = [CALayer new];
    newLayer.frame = CGRectMake(frame.x, frame.y, frame.w, frame.h);
    newLayer.backgroundColor = bg.CGColor;
    newLayer.cornerRadius = radius;
    newLayer.masksToBounds = true;
    return newLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];

    sw = [UIScreen mainScreen].bounds.size.width;
    sh = [UIScreen mainScreen].bounds.size.height;

    [self app];
}

@end
