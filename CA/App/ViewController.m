//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

#define DISABLE_ANIMATION_START [CATransaction begin]; \
                                [CATransaction setDisableActions:YES];

#define DISABLE_ANIMATION_END   [CATransaction commit];

@interface ViewController () {
    // MARK: LIB
    // UI
    NSMutableDictionary *dict;
    BOOL needsReappend;
    CADisplayLink *dl;
    CGFloat sw, sh;
    
    // INPUT
    // IMPROVEMENT:
    // I may not need nothing more than position for each of the touches
    NSSet<UITouch *> *touches;
    BOOL isTouched;
    
    // MARK: Extenders
    // Assets
    UIFont *fontRegular;
    
    // MARK: Builder
    ColorAnimation topLeftColorAnim;
    UIColor *currentTopLeftBoxColor;
    UIColor *topLeftTargetColor;
}
@end

@implementation ViewController

// TODO: ->
// Modifiers
- (void)loop {
    UITouch *currentTouch = touches.allObjects.firstObject;
    CGFloat x = [currentTouch locationInView:self.view].x;
    CGFloat y = [currentTouch locationInView:self.view].y;
    
    UIColor *target = (x < sw / 2 && y < sh / 2) ? [UIColor grayColor] : [UIColor blackColor];
    if (topLeftTargetColor != target) {
        [self startColorTransitionFrom:currentTopLeftBoxColor to:target duration:0.15];
        topLeftTargetColor = target;
    }
    
    if (topLeftColorAnim.active) {
        CFTimeInterval now = CACurrentMediaTime();
        CFTimeInterval elapsed = now - topLeftColorAnim.start;
        CGFloat t = MIN(elapsed / topLeftColorAnim.duration, 1.0);
        
        CGFloat r1, g1, b1, a1;
        CGFloat r2, g2, b2, a2;
        
        [topLeftColorAnim.from getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
        [topLeftColorAnim.to getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
        
        currentTopLeftBoxColor = [UIColor colorWithRed:(r1 + (r2 - r1) * t)
                                          green:(g1 + (g2 - g1) * t)
                                           blue:(b1 + (b2 - b1) * t)
                                          alpha:(a1 + (a2 - a1) * t)];
        
        if (t >= 1.0) {
            topLeftColorAnim.active = NO;
        }
    }

        
    [self
        createTextLayer:@"Admiral"
        frame:CGRectMake(50.0f, 50.0f, 50.0f, 20.0f)
        state:[self
            labelState:@"Admiral Capo"
            font:fontRegular
            foreground:[UIColor blackColor]
            alignment:kCAAlignmentLeft
            zIndex:5]];
    
    [self
        createLayer:@"YellowLayer"
        frame:CGRectMake(0.0f, 0, sw / 2, sh / 2)
        state:[self
            layerState:currentTopLeftBoxColor]];
    
    [self
        createLayer:@"BlueLayer"
        frame:CGRectMake(sw / 2, 0.0f, sw / 2, sh / 2)
        state:[self
            layerState:[UIColor blueColor]]];

    [self
        createLayer:@"RedLayer"
        frame:CGRectMake(0.0f, sh / 2, sw / 2, sh / 2)
        state:[self
            layerState:[UIColor redColor]]];

    [self
        createLayer:@"GreenLayer"
        frame:CGRectMake(sw / 2, sh / 2, sw / 2, sh / 2)
        state:[self
            layerState:[UIColor greenColor]]];

    [self append];
    
    NSLog(@"FPS %f", 1 / (dl.targetTimestamp - dl.timestamp));
}

- (void)startColorTransitionFrom:(UIColor *)from to:(UIColor *)to duration:(CGFloat)duration {
    topLeftColorAnim.active = YES;
    topLeftColorAnim.start = CACurrentMediaTime();
    topLeftColorAnim.duration = duration;
    topLeftColorAnim.from = from;
    topLeftColorAnim.to = to;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];
    
    dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(loop)];
    [dl addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    sw = [UIScreen mainScreen].bounds.size.width;
    sh = [UIScreen mainScreen].bounds.size.height;

    dict = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    // Fonts
    fontRegular = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    
    // Builder
    currentTopLeftBoxColor = [UIColor grayColor];
}

// MARK: LIB

// State
// TODO(Michal): Possible memory leak
- (UIState *)
    labelState:(NSString *)text font:(UIFont *)font foreground:(UIColor *)foreground
    alignment:(NSString *)align zIndex:(CGFloat)zIndex {
    DISABLE_ANIMATION_START
    
    UIState *state = malloc(sizeof(UIState));
    state->tag = LabelState;
    state->label.text = text;
    state->label.font = font;
    state->label.foreground = foreground;
    state->label.align = align;
    state->label.zIndex = zIndex;
    
    DISABLE_ANIMATION_END
    return state;
}

- (UIState *) layerState:(UIColor *)background {
    DISABLE_ANIMATION_START
    
    UIState *state = malloc(sizeof(UIState));
    state->tag = LayerState;
    state->layer.backround = background;
    
    DISABLE_ANIMATION_END
    return state;
}

// UI
- (CATextLayer *)
    createTextLayer:(NSString *)name frame:(CGRect)frame
    state:(struct UIState *)state {
    DISABLE_ANIMATION_START
    
    CATextLayer *tl = dict[name];
    if (!tl) {
        tl = [CATextLayer new];
        dict[name] = tl;
        needsReappend = true;
    }
    
    tl.string = state->label.text;
    tl.font = (__bridge CFTypeRef)state->label.font;
    tl.fontSize = state->label.font.pointSize;
    tl.foregroundColor = state->label.foreground.CGColor;
    tl.frame = frame;
    tl.contentsScale = [UIScreen mainScreen].scale;
    tl.zPosition = state->label.zIndex;

    DISABLE_ANIMATION_END
    return tl;
}

- (CALayer *)createLayer:(NSString *)name frame:(CGRect)frame state:(struct UIState *)s {
    CALayer *cl = dict[name];
    if (!cl) {
        cl = [CALayer new];
        dict[name] = cl;
        needsReappend = true;
    }
    
    DISABLE_ANIMATION_START
    
    cl.frame = frame;
    cl.backgroundColor = s->layer.backround.CGColor;
    
    DISABLE_ANIMATION_END
    return cl;
}

// Input
- (void)touchesBegan:(NSSet<UITouch *> *)ts withEvent:(UIEvent *)event {
    touches = ts;
    isTouched = true;
}

-(void)touchesMoved:(NSSet<UITouch *> *)ts withEvent:(UIEvent *)event {
    touches = ts;
    isTouched = true;
}

-(void)touchesEnded:(NSSet<UITouch *> *)ts withEvent:(UIEvent *)event {
    isTouched = false;
}

// Rest

- (void)append {
    if (!needsReappend) return;
    
    self.view.layer.sublayers = nil;
    
    for (CALayer *o in [dict allValues]) {
        [self.view.layer addSublayer:o];
    }
}

@end
