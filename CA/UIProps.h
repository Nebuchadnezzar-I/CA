//
//  UIProps.m
//  CA
//
//  Created by Michal Ukropec on 20/7/25.
//

#import <UIKit/UIKit.h>

typedef struct {
    BOOL active;
    CFTimeInterval start;
    CFTimeInterval duration;
    UIColor *from;
    UIColor *to;
} ColorAnimation;

typedef enum { LabelState, LayerState } UIStateType;

typedef struct UIState {
    UIStateType tag;

    union {
        struct {
            NSString *text;
            UIFont *font;
            UIColor *foreground;
            NSString *align;
            CGFloat zIndex;
        } label;

        struct {
            UIColor *backround;
        } layer;
    };
} UIState;
