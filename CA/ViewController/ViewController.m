//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

@interface ViewController () {
    CGFloat SW, SH;

    CALayer *header,
            *under1, *under2;
    UIScrollView *scroll;
}
@end

#define BY(E) E.frame.size.height + E.frame.origin.y
#define BX(E) E.frame.size.width + E.frame.origin.x

#define TY(E) E.frame.origin.y
#define TX(E) E.frame.origin.x

#define WIDTH(E)  E.bounds.size.width
#define HEIGHT(E) E.bounds.size.height

@implementation ViewController

- (void)ui {
    header = [self
        createLayer:[self TX:16 TY:72 BX:SW - 16 BY:136]
        background:[UIColor redColor]];
    
    scroll = [self
        createScroll:[self TX:TX(header) TY:BY(header) + 16 BX:BX(header) BY:SH - 72]
        diration:S_VERTICAL];
    
    under1 = [self
        createLayer:[self X:0 Y:16 W:WIDTH(scroll) H:64]
        background:[UIColor blueColor]];
    
    under2 = [self
        createLayer:[self X:0 Y:BY(under1) + 16 W:WIDTH(scroll) H:64]
        background:[UIColor blueColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];
    SW = [UIScreen mainScreen].bounds.size.width;
    SH = [UIScreen mainScreen].bounds.size.height;
    
    UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
    [appearance configureWithOpaqueBackground];
    appearance.backgroundColor = [UIColor clearColor];
    appearance.shadowColor = nil;
    self.navigationController.navigationBar.standardAppearance = appearance;
    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;

    [self ui];
    [self.view.layer addSublayer:header];
    [self.view addSubview:scroll];
        [scroll.layer addSublayer:under1];
        [scroll.layer addSublayer:under2];
}

//

typedef enum { S_VERTICAL, S_HORIZONTAL } ScrollDirction;
- (UIScrollView *)createScroll:(CGRect)frame diration:(ScrollDirction)dir {
    UIScrollView *_s = [[UIScrollView alloc] initWithFrame:frame];
    _s.bounces = YES;
    _s.decelerationRate = UIScrollViewDecelerationRateNormal;
    _s.scrollEnabled = YES;
    _s.clipsToBounds = YES;
    _s.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    if (dir == S_VERTICAL) {
        _s.contentSize = CGSizeMake(CGRectGetWidth(frame), 2000);
        _s.alwaysBounceVertical = YES;
        _s.showsVerticalScrollIndicator = YES;
        _s.showsHorizontalScrollIndicator = NO;
    } else {
        _s.contentSize = CGSizeMake(2000, CGRectGetHeight(frame));
        _s.alwaysBounceHorizontal = YES;
        _s.showsHorizontalScrollIndicator = YES;
        _s.showsVerticalScrollIndicator = NO;
    }

    return _s;
}

- (CALayer *)createLayer:(CGRect)frame background:(UIColor *)background {
    CALayer *_l = [CALayer new];
    _l.frame = frame;
    _l.backgroundColor = background.CGColor;
    return _l;
}

- (CGRect)X:(CGFloat)x Y:(CGFloat)y W:(CGFloat)w H:(CGFloat)h {
    return CGRectMake(x, y, w, h);
}

- (CGRect)TX:(CGFloat)tx TY:(CGFloat)ty BX:(CGFloat)bx BY:(CGFloat)by {
    CGRect _r = CGRectMake(tx, ty, bx - tx, by - ty);
    return _r;
}

@end
