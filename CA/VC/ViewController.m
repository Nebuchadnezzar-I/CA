//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

typedef struct {
    UIFont *fontTitleXL;
    UIFont *fontTitle;
    UIFont *fontSubtitle;
    UIFont *fontBody;
    UIFont *fontBodyBold;
    UIFont *fontCaption;
    UIFont *fontButton;
    UIFont *fontCode;
    UIFont *fontSmall;
    UIFont *fontLargeNumber;
} FontSet;

typedef struct {
    CGFloat fontTitleXL;
    CGFloat fontTitle;
    CGFloat fontSubtitle;
    CGFloat fontBody;
    CGFloat fontBodyBold;
    CGFloat fontCaption;
    CGFloat fontButton;
    CGFloat fontCode;
    CGFloat fontSmall;
    CGFloat fontLargeNumber;
} FontHeights;

static FontSet F;
static FontHeights FH;

static inline void LoadFonts(void) {
    F.fontTitleXL     = [UIFont systemFontOfSize:32 weight:UIFontWeightBold];
    F.fontTitle       = [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
    F.fontSubtitle    = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
    F.fontBody        = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    F.fontBodyBold    = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    F.fontCaption     = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    F.fontButton      = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    F.fontCode        = [UIFont monospacedSystemFontOfSize:14 weight:UIFontWeightRegular];
    F.fontSmall       = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    F.fontLargeNumber = [UIFont systemFontOfSize:42 weight:UIFontWeightMedium];

    FH.fontTitleXL     = F.fontTitleXL.lineHeight;
    FH.fontTitle       = F.fontTitle.lineHeight;
    FH.fontSubtitle    = F.fontSubtitle.lineHeight;
    FH.fontBody        = F.fontBody.lineHeight;
    FH.fontBodyBold    = F.fontBodyBold.lineHeight;
    FH.fontCaption     = F.fontCaption.lineHeight;
    FH.fontButton      = F.fontButton.lineHeight;
    FH.fontCode        = F.fontCode.lineHeight;
    FH.fontSmall       = F.fontSmall.lineHeight;
    FH.fontLargeNumber = F.fontLargeNumber.lineHeight;
}

@interface ViewController () {
    CGRect screen;
}
@end

@implementation ViewController

- (void)render {
    // TODO: Add TextLayer,flex
    CGRect HeaderLayout = R(A(screen) + 16, B(screen) + 72, C(screen) - 32, 64);
        CGRect HeaderSearchLayout = R(A(HeaderLayout) + 24, CE(HeaderLayout, 20), 20, 20);
        CGRect HeaderOptionsLayout = R(C(HeaderLayout) - 44, CE(HeaderLayout, 20), 20, 20);
        CGRect HeaderTextLayer = R(C(HeaderSearchLayout) + 16, CE(HeaderLayout, FH.fontBody), IN(HeaderSearchLayout, HeaderOptionsLayout, 32), FH.fontBody);
    CGRect AwningLayer = R(A(screen), 300, W(screen), H(screen) - 300);
    
    LAYER(Header, HeaderLayout, BACKGROUND(COLOR_NAMED(@"Component")), RADIUS(32));
        IMAGE(HeaderSearch, HeaderSearchLayout, @"Search");
        TEXT(HeaderText, HeaderTextLayer, @"Search", F.fontBody); // TODO: Pass font, not this.
        IMAGE(HeaderOptions, HeaderOptionsLayout, @"Options");
    
    LAYER(Rolette, AwningLayer, BACKGROUND(COLOR_NAMED(@"Component")), RADIUS(48))
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];

    srand48(time(NULL));
    LoadFonts();

    // Bounds
    screen = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                               [UIScreen mainScreen].bounds.size.height);
    
    [self render];
}

@end
