//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

@interface ViewController () {
    CGRect screen;
}
@end

@implementation ViewController

- (void)render {
    CGRect HeaderLayout = R(A(screen) + 16, B(screen) + 72, C(screen) - 32, 64);
    CGRect IconLayout = R(A(screen) + 16, D(HeaderLayout) + 0, C(screen) - 32, 64);

    LAYER(Header, HeaderLayout,
          BACKGROUND(COLOR(redColor)),
          RADIUS(12),
          OPACITY(0.8),
          BORDER_WIDTH(4),
          BORDER_COLOR(COLOR(blueColor)));
    
    LAYER(Icon, IconLayout,
          BACKGROUND(COLOR(redColor)),
          RADIUS(12),
          OPACITY(0.8),
          BORDER_WIDTH(4),
          BORDER_COLOR(COLOR(blueColor)));

    // TODO: Add TextLayer, ImageLayer, Layout centering, grid, flex
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];

    srand48(time(NULL));

    screen = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                               [UIScreen mainScreen].bounds.size.height);

    [self render];
}

@end
