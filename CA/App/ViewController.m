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

- (void)app {
    // MARK: Header
    CALayer *search = [CALayer new];
    search.frame = CGRectMake(24.0f, 72.0f, sw - 24.0f * 2, 64.0f);
    search.backgroundColor = [UIColor colorNamed:@"Component"].CGColor;
    search.cornerRadius = 32.0f;
    search.masksToBounds = true;
    [self.view.layer addSublayer:search];
    
    //
    CALayer *searchImageLayer = [CALayer layer];
    searchImageLayer.frame = CGRectMake(24.0f + 24.0f, 72.0f + 22.0f, 20.0f, 20.0f);

    UIImage *searchImage = [UIImage imageNamed:@"Search"];
    searchImageLayer.contents = (__bridge id)searchImage.CGImage;
    searchImageLayer.contentsGravity = kCAGravityResizeAspect;
    searchImageLayer.contentsScale = [UIScreen mainScreen].scale;

    [self.view.layer addSublayer:searchImageLayer];
    //
    
    //
    UIFont *font = [ViewController searchFontWithSize:17.0f];
    CGFloat height = [ViewController heightForText:@"Search" font:font maxWidth:200.0f];
    
    CATextLayer *searchTextLayer = [CATextLayer layer];
    searchTextLayer.frame = CGRectMake(84.0f, 72.0f + (64.0f - height) / 2, 200.0f, height);
    searchTextLayer.string = @"Search";
    searchTextLayer.font = (__bridge CFTypeRef)[UIFont systemFontOfSize:17.0f];
    searchTextLayer.fontSize = 17.0f;
    searchTextLayer.foregroundColor = [UIColor labelColor].CGColor;
    searchTextLayer.contentsScale = [UIScreen mainScreen].scale;
    searchTextLayer.alignmentMode = kCAAlignmentLeft;
    searchTextLayer.truncationMode = kCATruncationEnd;

    [self.view.layer addSublayer:searchTextLayer];
    //
    
    //
    CALayer *optionsImageLayer = [CALayer layer];
    optionsImageLayer.frame = CGRectMake(sw - 22.0f - 24.0f - 24.0f, 72.0f + 23.0f, 22.0f, 18.0f);

    UIImage *optionsImage = [UIImage imageNamed:@"Options"];
    optionsImageLayer.contents = (__bridge id)optionsImage.CGImage;
    optionsImageLayer.contentsGravity = kCAGravityResizeAspect;
    optionsImageLayer.contentsScale = [UIScreen mainScreen].scale;

    [self.view.layer addSublayer:optionsImageLayer];
    //
    
    // MARK: body
    CALayer *mainBody = [CALayer new];
    mainBody.frame = CGRectMake(0.0f, sh - 64.0 - 56.0 - 56.0 - 48.0 - 156.0 - 8.0 - 156.0 - 16.0 - 16.0f, sw, 576 + 32);
    mainBody.backgroundColor = [UIColor colorNamed:@"Component"].CGColor;
    mainBody.cornerRadius = 48.0f;
    mainBody.masksToBounds = true;
    
    [self.view.layer addSublayer:mainBody];
    //
    
    // Selector
    CALayer *flightSelector = [CALayer new];
    flightSelector.frame = CGRectMake(16.0f, sh - 64.0 - 56.0 - 56.0 - 48.0 - 156.0 - 8.0 - 156.0 - 16.0, sw - 16.0f * 2, 56.0f);
    flightSelector.backgroundColor = [UIColor colorNamed:@"Secondary"].CGColor;
    flightSelector.cornerRadius = 28.0f;
    flightSelector.masksToBounds = true;
    [self.view.layer addSublayer:flightSelector];
    //
    
    // Left button
    UIFont *lbFont = [ViewController searchFontWithSize:14.0f];
    NSString *tfText = @"Trending flights";
    NSString *fnyText = @"Flights near you";

    CGFloat tfHeight = [ViewController heightForText:tfText font:lbFont maxWidth:200.0f];
    CGFloat fnyHeight = [ViewController heightForText:fnyText font:lbFont maxWidth:200.0f];


    CALayer *lbTextLayer = [CALayer new];
    lbTextLayer.frame = CGRectMake(16 + 4, sh - 64.0 - 56.0 - 56.0 - 48.0 - 156.0 - 8.0 - 156.0 - 16.0 + 3, (sw - 16.0f * 2) / 2 - 6, 50.0f);
    lbTextLayer.backgroundColor = [UIColor whiteColor].CGColor;
    lbTextLayer.cornerRadius = 24.0f;
    lbTextLayer.masksToBounds = true;

    [self.view.layer addSublayer:lbTextLayer];
    //
    
    // right button
    CALayer *rbTextLayer = [CALayer new];
    rbTextLayer.frame = CGRectMake((sw - 16.0f * 2) / 2 + 16 + 2, sh - 64.0 - 56.0 - 56.0 - 48.0 - 156.0 - 8.0 - 156.0 - 16.0 + 3, (sw - 16.0f * 2) / 2 - 6, 50.0f);
    rbTextLayer.cornerRadius = 24.0f;
    rbTextLayer.masksToBounds = true;

    [self.view.layer addSublayer:rbTextLayer];
    //
    
    // Left button text
    CATextLayer *lbLabel = [CATextLayer layer];
    lbLabel.string = tfText;
    lbLabel.font = (__bridge CFTypeRef)lbFont;
    lbLabel.fontSize = 14.0f;
    lbLabel.foregroundColor = [UIColor labelColor].CGColor;
    lbLabel.contentsScale = [UIScreen mainScreen].scale;
    lbLabel.alignmentMode = kCAAlignmentCenter;
    lbLabel.truncationMode = kCATruncationEnd;
    lbLabel.foregroundColor = [UIColor colorNamed:@"Component"].CGColor;

    CGFloat lbTextY = lbTextLayer.frame.origin.y + (lbTextLayer.frame.size.height - tfHeight) / 2.0f;
    lbLabel.frame = CGRectMake(
        lbTextLayer.frame.origin.x,
        lbTextY,
        lbTextLayer.frame.size.width,
        tfHeight
    );
    [self.view.layer addSublayer:lbLabel];

    // Right button text
    CATextLayer *rbLabel = [CATextLayer layer];
    rbLabel.string = fnyText;
    rbLabel.font = (__bridge CFTypeRef)lbFont;
    rbLabel.fontSize = 14.0f;
    rbLabel.foregroundColor = [UIColor whiteColor].CGColor;
    rbLabel.contentsScale = [UIScreen mainScreen].scale;
    rbLabel.alignmentMode = kCAAlignmentCenter;
    rbLabel.truncationMode = kCATruncationEnd;

    CGFloat rbTextY = rbTextLayer.frame.origin.y + (rbTextLayer.frame.size.height - fnyHeight) / 2.0f;
    rbLabel.frame = CGRectMake(
        rbTextLayer.frame.origin.x,
        rbTextY,
        rbTextLayer.frame.size.width,
        fnyHeight
    );
    [self.view.layer addSublayer:rbLabel];
    
    // MARK: Posts
    // TODO: Finish xD

    CALayer *firstRes = [CALayer new];
    firstRes.frame = CGRectMake(16.0f, sh - 64 - 56 - 156 - 156 - 8 - 48, sw - 32.0f, 156.0f);
    firstRes.backgroundColor = [UIColor colorNamed:@"Secondary"].CGColor;
    firstRes.cornerRadius = 24;
    firstRes.masksToBounds = true;
    [self.view.layer addSublayer:firstRes];
    
    CALayer *secondRes = [CALayer new];
    secondRes.frame = CGRectMake(16.0f, sh - 64 - 56 - 156 - 48, sw - 32.0f, 156.0f);
    secondRes.backgroundColor = [UIColor colorNamed:@"Secondary"].CGColor;
    secondRes.cornerRadius = 24;
    secondRes.masksToBounds = true;
    [self.view.layer addSublayer:secondRes];
    
    // MARK: Footer
    CGFloat center = sw / 2;
    
    CALayer *homeNavLayer = [CALayer layer];
    homeNavLayer.frame = CGRectMake(center - 148.0f, sh - 120.0f, 56.0f, 56.0f);
    homeNavLayer.backgroundColor = UIColor.whiteColor.CGColor;
    homeNavLayer.cornerRadius = 28.0f;
    homeNavLayer.masksToBounds = YES;
    [self.view.layer addSublayer:homeNavLayer];

    CALayer *icon = [CALayer layer];
    icon.frame = CGRectMake(18.0f, 17.0f, 20.0f, 22.0f);
    icon.contents = (__bridge id)[UIImage imageNamed:@"Home"].CGImage;
    icon.contentsGravity = kCAGravityResizeAspect;
    icon.contentsScale = UIScreen.mainScreen.scale;
    [homeNavLayer addSublayer:icon];

    //
    
    CALayer *searchNavLayer = [CALayer layer];
    searchNavLayer.frame = CGRectMake(center - 56 - 12, sh - 64.0 - 56.0, 56.0f, 56.0f);
    searchNavLayer.cornerRadius = 28.0f;
    searchNavLayer.masksToBounds = YES;
    [self.view.layer addSublayer:searchNavLayer];

    CALayer *searchIcon = [CALayer layer];
    searchIcon.frame = CGRectMake(18.0f, 18.0f, 20.0f, 20.0f); // centered inside 56x56
    searchIcon.contents = (__bridge id)[UIImage imageNamed:@"Search"].CGImage;
    searchIcon.contentsGravity = kCAGravityResizeAspect;
    searchIcon.contentsScale = UIScreen.mainScreen.scale;
    [searchNavLayer addSublayer:searchIcon];

    //
    
    CALayer *saveNavLayer = [CALayer layer];
    saveNavLayer.frame = CGRectMake(center + 12.0f, sh - 64.0f - 56.0f, 56.0f, 56.0f);
    saveNavLayer.cornerRadius = 28.0f;
    saveNavLayer.masksToBounds = YES;
    [self.view.layer addSublayer:saveNavLayer];

    CALayer *saveIcon = [CALayer layer];
    saveIcon.frame = CGRectMake(20.0f, 18.0f, 16.0f, 20.0f);
    saveIcon.contents = (__bridge id)[UIImage imageNamed:@"Save"].CGImage;
    saveIcon.contentsGravity = kCAGravityResizeAspect;
    saveIcon.contentsScale = UIScreen.mainScreen.scale;
    [saveNavLayer addSublayer:saveIcon];
    
    //
    
    CALayer *userNavLayer = [CALayer layer];
    userNavLayer.frame = CGRectMake(center + 12.0f + 56.0f + 24.0f, sh - 64.0f - 56.0f, 56.0f, 56.0f);
    userNavLayer.cornerRadius = 28.0f;
    userNavLayer.masksToBounds = YES;
    [self.view.layer addSublayer:userNavLayer];

    CALayer *userIcon = [CALayer layer];
    userIcon.frame = CGRectMake(18.0f, 16.5f, 20.0f, 23.0f);
    userIcon.contents = (__bridge id)[UIImage imageNamed:@"User"].CGImage;
    userIcon.contentsGravity = kCAGravityResizeAspect;
    userIcon.contentsScale = UIScreen.mainScreen.scale;
    [userNavLayer addSublayer:userIcon];
    
    //
}

+ (UIFont *)searchFontWithSize:(CGFloat)size {
    return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
}

+ (CGFloat)heightForText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width {
    NSDictionary *attrs = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attrs
                                     context:nil];
    return ceil(rect.size.height);
}

+ (CGFloat)widthForText:(NSString *)text font:(UIFont *)font {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return ceil(rect.size.width);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Background"];
    
    sw = [UIScreen mainScreen].bounds.size.width;
    sh = [UIScreen mainScreen].bounds.size.height;
    
    [self app];
}

@end
