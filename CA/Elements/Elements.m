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

+ (CALayer *)createLayer:(CGRect)rect background:(UIColor *)color {
    CALayer *_l = [CALayer new];
    _l.frame = rect;
    _l.backgroundColor = color.CGColor;
    return _l;
}

@end
