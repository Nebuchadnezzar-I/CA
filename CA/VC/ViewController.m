//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

@interface ViewController () {
    CGFloat sw, sh;
}
@end

@implementation ViewController

- (void)render {
    LAYOUT(HeaderLayout,                    RECT(16, 72, sw - 32, 64));
        LAYOUT(LeftIconLayout,              RECT(LEADING(HeaderLayout) + 8, CENTER_IN(HeaderLayout, 48), 48, 48));
        LAYOUT(RightIconLayout,             RECT(TRAILING(HeaderLayout, 48, 8), CENTER_IN(HeaderLayout, 48), 48, 48));
    
    LAYOUT(SheetLayout,                     RECT(0, sh - 512, sw, 512));
        LAYOUT(SelectorLayout,              RECT(LEADING(HeaderLayout), TOP(SheetLayout) + 16, WIDTH(HeaderLayout), 56));
            LAYOUT(LeftSelectorBtnLayout,   RECT(LEADING(SelectorLayout) + 4, CENTER_IN(SelectorLayout, 48), (WIDTH(SelectorLayout) - 8 - 4) / 2, HEIGHT(SelectorLayout) - 8));
            LAYOUT(RightSelectorBtnLayout,  RECT(WIDTH(LeftSelectorBtnLayout) + 16 + 4 + 4, CENTER_IN(SelectorLayout, 48), WIDTH(LeftSelectorBtnLayout), HEIGHT(SelectorLayout) - 8));
        LAYOUT(FirstOptionLayout,           RECT(LEADING(SelectorLayout), BOTTOM(SelectorLayout) + 16, WIDTH(SelectorLayout), 156));
        LAYOUT(SecondOptionLayout,          RECT(LEADING(SelectorLayout), BOTTOM(FirstOptionLayout) + 8, WIDTH(SelectorLayout), 156));
        LAYOUT(ContinueBtnLayout,           RECT(LEADING(HeaderLayout), BOTTOM(SecondOptionLayout) + 16, sw - 32, 56));
    
    // Top Bar
    LAYER(Header,                           HeaderLayout,             lightGrayColor,   0.0,  1.0);
        LAYER(LeftIcon,                     LeftIconLayout,           darkGrayColor,    8.0,  0.8);
        LAYER(RightIcon,                    RightIconLayout,          darkGrayColor,    8.0,  0.8);

    // Sheet
    LAYER(Sheet,                            SheetLayout,              redColor,         16.0, 1.0);
        LAYER(Selector,                     SelectorLayout,           whiteColor,       12.0, 1.0);
            LAYER(LeftSelectorBtn,          LeftSelectorBtnLayout,    systemBlueColor,  8.0,  1.0);
            LAYER(RightSelectorBtn,         RightSelectorBtnLayout,   systemBlueColor,  8.0,  1.0);
        LAYER(FirstOption,                  FirstOptionLayout,        lightTextColor,   8.0,  0.9);
        LAYER(SecondOption,                 SecondOptionLayout,       lightTextColor,   8.0,  0.9);
        LAYER(ContinueBtn,                  ContinueBtnLayout,        greenColor,       10.0, 1.0);

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];

    srand48(time(NULL));

    sw = [UIScreen mainScreen].bounds.size.width;
    sh = [UIScreen mainScreen].bounds.size.height;

    [self render];
}

- (UIColor *)randColor {
    return [UIColor colorWithHue:drand48()
                      saturation:1.0
                      brightness:1.0
                           alpha:1.0];
}

@end
