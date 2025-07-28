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
    // TODO: Add TextLayer,flex, alignment to bottom
    CGRect HeaderLayout = R(A(screen) + 16, B(screen) + 72, C(screen) - 32, 64);
        CGRect HeaderSearchLayout = R(A(HeaderLayout) + 24, CE(HeaderLayout, 20), 20, 20);
        CGRect HeaderOptionsLayout = R(C(HeaderLayout) - 44, CE(HeaderLayout, 20), 20, 20);
        CGRect HeaderTextLayer = R(C(HeaderSearchLayout) + 16, CE(HeaderLayout, FH.fontBody), IN(HeaderSearchLayout, HeaderOptionsLayout, 32), FH.fontBody);
    CGRect AwningLayer = R(A(screen), 360, W(screen), H(screen) - 360);
        CGRect FilterLayout = R(A(AwningLayer) + 16, B(AwningLayer) + 16, W(AwningLayer) - 32, 56);
            CGRect OptionOneLayout = R(A(FilterLayout) + 4, B(FilterLayout) + 4, W(FilterLayout) / 2 - 6, 48);
            CGRect OptionOneTextLayout = R(A(FilterLayout) + 4, CE(FilterLayout, FH.fontBody), W(FilterLayout) / 2 - 6, FH.fontBody);
            CGRect OptionTwoTextLayout = R(C(OptionOneTextLayout) + 4, CE(FilterLayout, FH.fontBody), W(OptionOneTextLayout), FH.fontBody);
        CGRect FirstFlightLayout = R(A(AwningLayer) + 16, D(FilterLayout) + 16, W(FilterLayout), 150);
        CGRect SecondFlightLayout = R(A(FirstFlightLayout), D(FirstFlightLayout) + 8, W(FilterLayout), 150);
    
    CGRect NavSelectorLayout= R(W(screen) / 2 - 56 - 12 - 56 - 24, H(screen) - 112, 56, 56);
    CGRect NavHomeLayout = R(W(screen) / 2 - 56 - 12 - 56 - 24, H(screen) - 112, 56, 56);
        CGRect NavHomeIconLayout = R(A(NavHomeLayout) + (W(NavHomeLayout) - 22) / 2, B(NavHomeLayout) + (H(NavHomeLayout) - 24) / 2, 22, 24);
    CGRect SearchHomeLayout = R(W(screen) / 2 - 56 - 12, H(screen) - 112, 56, 56);
        CGRect NavSearchIconLayout = R(A(SearchHomeLayout) + (W(SearchHomeLayout) - 20) / 2, B(SearchHomeLayout) + (H(SearchHomeLayout) - 20) / 2, 20, 20);
    CGRect SaveHomeLayout = R(W(screen) / 2 + 12, H(screen) - 112, 56, 56);
        CGRect NavSaveIconLayout = R(A(SaveHomeLayout) + (W(SaveHomeLayout) - 16) / 2, B(SaveHomeLayout) + (H(SaveHomeLayout) - 20) / 2, 16, 20);
    CGRect UserHomeLayout = R(W(screen) / 2 + 12 + 56 + 24, H(screen) - 112, 56, 56);
        CGRect NavUserIconLayout = R(A(UserHomeLayout) + (W(UserHomeLayout) - 20) / 2, B(UserHomeLayout) + (H(UserHomeLayout) - 23) / 2, 20, 23);


    LAYER(Header, HeaderLayout, BACKGROUND(COLOR_NAMED(@"Component")), RADIUS(32));
        IMAGE(HeaderSearch, HeaderSearchLayout, @"Search");
        TEXT(HeaderText, HeaderTextLayer, @"Search", F.fontBody, _COLOR(lightGrayColor), NSTextAlignmentLeft);
        IMAGE(HeaderOptions, HeaderOptionsLayout, @"Options");
    
    LAYER(Rolette, AwningLayer, BACKGROUND(COLOR_NAMED(@"Component")), RADIUS(48))
        LAYER(Filter, FilterLayout, BACKGROUND(COLOR_NAMED(@"Secondary")), RADIUS(28))
            LAYER(OptionOne, OptionOneLayout, BACKGROUND(COLOR(whiteColor)), RADIUS(24));
            TEXT(OptionOneText, OptionOneTextLayout, @"Trending flights", F.fontBody, _COLOR_NAMED(@"Background"), NSTextAlignmentCenter);
            TEXT(OptionTwoText, OptionTwoTextLayout, @"Flights near you", F.fontBody, _COLOR(whiteColor), NSTextAlignmentCenter);
    
        LAYER(FirstFlight, FirstFlightLayout, BACKGROUND(COLOR_NAMED(@"Secondary")), RADIUS(24));
        LAYER(SecondFlight, SecondFlightLayout, BACKGROUND(COLOR_NAMED(@"Secondary")), RADIUS(24));
    
        LAYER(NavSelector, NavSelectorLayout, BACKGROUND(COLOR(whiteColor)), RADIUS(28));
        IMAGE(NavHomeIcon, NavHomeIconLayout, @"Home");
        IMAGE(NavSearchIcon, NavSearchIconLayout, @"Search");
        IMAGE(NavSaveIcon, NavSaveIconLayout, @"Save");
        IMAGE(NavUserIcon, NavUserIconLayout, @"User");
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
