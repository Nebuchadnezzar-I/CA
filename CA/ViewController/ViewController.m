//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"
#include <mach/mach_time.h>

#define APPEND_LAYERS()                                                        \
    for (CALayer * _l in [layers allValues]) {                                 \
        [self.view.layer addSublayer:_l];                                      \
    }

#define RUN_UI() [self ui];
#define APP_BG(COLOR) self.view.backgroundColor = COLOR;
#define SETUP_PROPS()                                                          \
    layers = [[NSMutableDictionary alloc] initWithCapacity:8];                 \
    SW = [UIScreen mainScreen].bounds.size.width;                              \
    SH = [UIScreen mainScreen].bounds.size.height;

#define LAYER(NAME, RECT, ...)                                                 \
    do {                                                                       \
        CALayer *_l = [CALayer new];                                           \
        _l.frame = RECT;                                                       \
        __VA_ARGS__;                                                           \
        layers[@(NAME)] = _l;                                                  \
    } while (0)

#define TEXT(NAME, RECT, ...)                                                  \
    do {                                                                       \
        CATextLayer *_l = [CATextLayer new];                                   \
        _l.frame = RECT;                                                       \
        _l.contentsScale = UIScreen.mainScreen.scale;                          \
        __VA_ARGS__;                                                           \
        layers[@(NAME)] = _l;                                                  \
    } while (0)

#define SCROLL()

// Modifiers
#define N_COLOR(VAL) [UIColor colorNamed:VAL]
#define S_COLOR(VAL) [UIColor VAL]
#define CG(COLOR) VAL.CGColor

#define RADIUS(VAL) _l.cornerRadius = VAL
#define BACKGROUND(VAL) _l.backgroundColor = VAL
#define STRING(VAL) _l.string = VAL
#define ALIGNMENT(VAL) _l.alignmentMode = VAL

#define DEFINE_FONT(NAME, SIZE, WEIGHT)                                        \
    static UIFont *NAME;                                                       \
    static void Init##NAME(void) {                                             \
        NAME = [UIFont systemFontOfSize:(SIZE) weight:(WEIGHT)];               \
    }

#define FH(FONT) FONT.pointSize

#define FW_LIGHT UIFontWeightLight
#define FW_REGULAR UIFontWeightRegular
#define FW_MEDIUM UIFontWeightMedium
#define FW_SEMIBOLD UIFontWeightSemibold
#define FW_BOLD UIFontWeightBold

#define FONT_TINY(WEIGHT, SUFFIX) DEFINE_FONT(font_tiny##SUFFIX, 11, WEIGHT)
#define FONT_SMALL(WEIGHT, SUFFIX) DEFINE_FONT(font_small##SUFFIX, 13, WEIGHT)
#define FONT_BODY(WEIGHT, SUFFIX) DEFINE_FONT(font_body##SUFFIX, 15, WEIGHT)
#define FONT_SUBTITLE(WEIGHT, SUFFIX)                                          \
    DEFINE_FONT(font_subtitle##SUFFIX, 17, WEIGHT)
#define FONT_TITLE(WEIGHT, SUFFIX) DEFINE_FONT(font_title##SUFFIX, 20, WEIGHT)
#define FONT_HEADLINE(WEIGHT, SUFFIX)                                          \
    DEFINE_FONT(font_headline##SUFFIX, 24, WEIGHT)
#define FONT_HERO(WEIGHT, SUFFIX) DEFINE_FONT(font_hero##SUFFIX, 32, WEIGHT)

#define ASSAMBLE_FONTS()                                                       \
    FONT_TINY(FW_LIGHT, light);                                                \
    FONT_SMALL(FW_LIGHT, light);                                               \
    FONT_BODY(FW_LIGHT, light);                                                \
    FONT_SUBTITLE(FW_LIGHT, light);                                            \
    FONT_TITLE(FW_LIGHT, light);                                               \
    FONT_HEADLINE(FW_LIGHT, light);                                            \
    FONT_HERO(FW_LIGHT, light);                                                \
                                                                               \
    FONT_TINY(FW_REGULAR, regular);                                            \
    FONT_SMALL(FW_REGULAR, regular);                                           \
    FONT_BODY(FW_REGULAR, regular);                                            \
    FONT_SUBTITLE(FW_REGULAR, regular);                                        \
    FONT_TITLE(FW_REGULAR, regular);                                           \
    FONT_HEADLINE(FW_REGULAR, regular);                                        \
    FONT_HERO(FW_REGULAR, regular);                                            \
                                                                               \
    FONT_TINY(FW_MEDIUM, medium);                                              \
    FONT_SMALL(FW_MEDIUM, medium);                                             \
    FONT_BODY(FW_MEDIUM, medium);                                              \
    FONT_SUBTITLE(FW_MEDIUM, medium);                                          \
    FONT_TITLE(FW_MEDIUM, medium);                                             \
    FONT_HEADLINE(FW_MEDIUM, medium);                                          \
    FONT_HERO(FW_MEDIUM, medium);                                              \
                                                                               \
    FONT_TINY(FW_SEMIBOLD, semibold);                                          \
    FONT_SMALL(FW_SEMIBOLD, semibold);                                         \
    FONT_BODY(FW_SEMIBOLD, semibold);                                          \
    FONT_SUBTITLE(FW_SEMIBOLD, semibold);                                      \
    FONT_TITLE(FW_SEMIBOLD, semibold);                                         \
    FONT_HEADLINE(FW_SEMIBOLD, semibold);                                      \
    FONT_HERO(FW_SEMIBOLD, semibold);                                          \
                                                                               \
    FONT_TINY(FW_BOLD, bold);                                                  \
    FONT_SMALL(FW_BOLD, bold);                                                 \
    FONT_BODY(FW_BOLD, bold);                                                  \
    FONT_SUBTITLE(FW_BOLD, bold);                                              \
    FONT_TITLE(FW_BOLD, bold);                                                 \
    FONT_HEADLINE(FW_BOLD, bold);                                              \
    FONT_HERO(FW_BOLD, bold);

#define INIT_FONTS()                                                           \
    Initfont_tinylight();                                                      \
    Initfont_smalllight();                                                     \
    Initfont_bodylight();                                                      \
    Initfont_subtitlelight();                                                  \
    Initfont_titlelight();                                                     \
    Initfont_headlinelight();                                                  \
    Initfont_herolight();                                                      \
                                                                               \
    Initfont_tinyregular();                                                    \
    Initfont_smallregular();                                                   \
    Initfont_bodyregular();                                                    \
    Initfont_subtitleregular();                                                \
    Initfont_titleregular();                                                   \
    Initfont_headlineregular();                                                \
    Initfont_heroregular();                                                    \
                                                                               \
    Initfont_tinymedium();                                                     \
    Initfont_smallmedium();                                                    \
    Initfont_bodymedium();                                                     \
    Initfont_subtitlemedium();                                                 \
    Initfont_titlemedium();                                                    \
    Initfont_headlinemedium();                                                 \
    Initfont_heromedium();                                                     \
                                                                               \
    Initfont_tinysemibold();                                                   \
    Initfont_smallsemibold();                                                  \
    Initfont_bodysemibold();                                                   \
    Initfont_subtitlesemibold();                                               \
    Initfont_titlesemibold();                                                  \
    Initfont_headlinesemibold();                                               \
    Initfont_herosemibold();                                                   \
                                                                               \
    Initfont_tinybold();                                                       \
    Initfont_smallbold();                                                      \
    Initfont_bodybold();                                                       \
    Initfont_subtitlebold();                                                   \
    Initfont_titlebold();                                                      \
    Initfont_headlinebold();                                                   \
    Initfont_herobold();

#define RADIUS(VAL) _l.cornerRadius = VAL
#define BACKGROUND(VAL) _l.backgroundColor = VAL
#define STRING(VAL) _l.string = VAL
#define ALIGNMENT(VAL) _l.alignmentMode = VAL
#define FONT(FONT)                                                             \
    _l.fontSize = FH(FONT);                                                    \
    _l.font = (__bridge CFTypeRef)(FONT)

@interface ViewController () {
    NSMutableDictionary *layers;
    CGFloat SW, SH;
}
@end

@implementation ViewController
ASSAMBLE_FONTS()

- (void)ui {
    TEXT("Header", [Elements X:16 Y:82 W:SW - 32 H:FH(font_herolight)],
         STRING(@"Header"), FONT(font_herolight));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    HIDE_HEADER();
    APP_BG(N_COLOR(@"Backgorund"));
    SETUP_PROPS();
    INIT_FONTS();
    RUN_UI();
    APPEND_LAYERS();
}

@end
