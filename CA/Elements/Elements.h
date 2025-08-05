//
//  Elements.h
//  Elements
//
//  Created by Michal Ukropec on 18/7/25.
//

#import <UIKit/UIKit.h>

@interface Elements : UIViewController

// Data
typedef enum { S_VERTICAL, S_HORIZONTAL } ScrollDirction;

// Elements
+ (UIScrollView *)createScroll:(CGRect)frame diration:(ScrollDirction)dir;

// Layout
+ (CGRect)X:(CGFloat)x Y:(CGFloat)y W:(CGFloat)w H:(CGFloat)h;
+ (CGRect)TX:(CGFloat)tx TY:(CGFloat)ty BX:(CGFloat)bx BY:(CGFloat)by;

@end

// Macros

#define BY(E) E.frame.size.height + E.frame.origin.y
#define BX(E) E.frame.size.width + E.frame.origin.x

#define TY(E) E.frame.origin.y
#define TX(E) E.frame.origin.x

#define WIDTH(E)  E.bounds.size.width
#define HEIGHT(E) E.bounds.size.height

#define HIDE_HEADER()                                                          \
    UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];   \
    [appearance configureWithOpaqueBackground];                                \
    appearance.backgroundColor = [UIColor clearColor];                         \
    appearance.shadowColor = nil;                                              \
    self.navigationController.navigationBar.standardAppearance = appearance;   \
    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
