//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "Elements.h"

@interface Elements ()
@end

@implementation Elements

+ (UIScrollView *)createScroll:(CGRect)frame diration:(ScrollDirction)dir {
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

+ (CGRect)X:(CGFloat)x Y:(CGFloat)y W:(CGFloat)w H:(CGFloat)h {
    return CGRectMake(x, y, w, h);
}

+ (CGRect)TX:(CGFloat)tx TY:(CGFloat)ty BX:(CGFloat)bx BY:(CGFloat)by {
    return CGRectMake(tx, ty, bx - tx, by - ty);
}

@end
