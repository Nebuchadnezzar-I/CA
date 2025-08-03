//
//  ViewController.m
//  CA
//
//  Created by Michal Ukropec on 18/7/25.
//

#import "ViewController.h"

@interface ViewController () {
    CGFloat sw, sh;

    CALayer *header, *searchIcon, *settingsIcon, *searchText;
}
@end

@implementation ViewController

- (void)ui {
    header = LAYER(RECT(24, 72, sw - 48, 64),
                   BG(COLOR(colorNamed : @"Component")), RADIUS(32));
    
    searchIcon = LAYER(RECT(L(header) + 24, CENTER_Y(header, 20), 20, 20),
                       IMG(imageNamed:@"Search"));
    
    settingsIcon = LAYER(RECT(RA(header) - 22 - 24, CENTER_Y(header, 18), 22, 18),
                       IMG(imageNamed:@"Options"));
    
    searchText = TEXT(RECT(CENTER_BETWEEN(searchIcon, settingsIcon, header, 20, 16)));
    
    
    [self.view.layer addSublayer:header];
    [self.view.layer addSublayer:searchIcon];
    [self.view.layer addSublayer:settingsIcon];
    [self.view.layer addSublayer:searchText];

    RECOGNIZERS(2.0, 2);
}

RECOGNIZER

- (void)perform:(GesturePayload)payload {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.30];
    
    switch (payload.cmd) {
        case G_TAP:
            if (![header hitTest:payload.swipe.location]) break;
            //
            header.frame = CGRectMake(0, 0, sw, sh);
            header.cornerRadius = 0;
            //
            searchIcon.frame = RECT(L(header) + 24, 72 + 22, 20, 20);
            settingsIcon.frame = RECT(RA(header) - 24 - 22, 72 + 22, 22, 18);
            searchText.frame = RECT(RA(searchIcon) + 16, T(searchText), W(searchText), H(searchText));
            break;
        case G_DOUBLE_TAP:
            if (![header hitTest:payload.swipe.location]) break;
            header.frame = RECT(24, 72, sw - 48, 64);
            header.cornerRadius = 32;
            searchIcon.frame = RECT(L(header) + 24, CENTER_Y(header, 20), 20, 20);
            settingsIcon.frame = RECT(RA(header) - 22 - 24, CENTER_Y(header, 18), 22, 18);
            searchText.frame = RECT(CENTER_BETWEEN(searchIcon, settingsIcon, header, 20, 16));
            break;
        default:
            break;
    }
    
    [CATransaction commit];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];
    sw = [UIScreen mainScreen].bounds.size.width;
    sh = [UIScreen mainScreen].bounds.size.height;

    [self ui];
}

@end
