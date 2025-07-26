//
//  ViewController.h
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat x, y, w, h;
} Layout;

#define RECT(X, Y, W, H) {.x = X, .y = Y, .w = W, .h = H}
#define BOTTOM(LAYER) TOP(LAYER) + HEIGHT(LAYER)
#define TRAILING(LAYER, SIZE, OFFSET) sw - LEADING(LAYER) - SIZE - OFFSET
#define TRAILING_OFFSET(LAYER, OFFSET) WIDTH(LAYER) - LEADING(LAYER) - OFFSET
#define CENTER_IN(PARENT, CHILD_HEIGHT)                                        \
    TOP(PARENT) + ((HEIGHT(PARENT) - CHILD_HEIGHT) / 2)

//

#define LEADING(RECT) RECT.x
#define TOP(RECT) RECT.y
#define WIDTH(RECT) RECT.w
#define HEIGHT(RECT) RECT.h

#define LAYOUT(NAME, RECT) Layout NAME = RECT
// TODO: Add border
#define LAYER(NAME, RECT, BG, RADIUS, OPACITY)                                 \
    CALayer *NAME = [CALayer new];                                             \
    NAME.frame = CGRectMake(RECT.x, RECT.y, RECT.w, RECT.h);                   \
    NAME.opacity = OPACITY;                                                    \
    NAME.cornerRadius = RADIUS;                                                \
    NAME.masksToBounds = true;                                                 \
    NAME.backgroundColor = [UIColor BG].CGColor;                               \
    [self.view.layer addSublayer:NAME];

@interface ViewController : UIViewController
@end
