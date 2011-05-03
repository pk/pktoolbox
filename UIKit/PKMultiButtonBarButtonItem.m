//
//  PKMultiButtonBarButtonItem.m
//  PKToolbox
//
//  Created by Pavel Kunc on 02/05/2011.
//  Copyright 2011 Fry-it, Limited. All rights reserved.
//

#import "PKMultiButtonBarButtonItem.h"


@implementation PKMultiButtonBarButtonItem

#pragma mark - Creating bar button toolbars

+ (UIBarButtonItem *)barButtonItemWithButtons:(UIBarButtonItem *)firstArg, ... {
    NSMutableArray *buttons = [[NSMutableArray alloc] init];

    va_list args;
    va_start(args, firstArg);
    for (UIBarButtonItem *arg = firstArg; arg != nil; arg = va_arg(args, UIBarButtonItem*)) {
        [buttons addObject:arg];
    }
    va_end(args);

    UIBarButtonItem *item = [self barButtonItemWithArray:buttons];
    [buttons release];
    return item;
}

+ (UIBarButtonItem *)barButtonItemWithArray:(NSArray *)aButtons {
    float width = 0.0;
    for (UIBarButtonItem *button in aButtons) {
        if (button.width == 0.0) {
            switch (button.tag) {
                case UIBarButtonSystemItemRefresh:
                    width += 30.0;
                    break;
                case UIBarButtonSystemItemDone:
                    width += 55.0;
                    break;
                default:
                    break;
            }
            continue;
        }
        width += button.width;
    }
    width += (float)[aButtons count] * 5.0;

    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 44.01)];
    toolbar.translucent = YES;
    [toolbar setBarStyle:UIBarStyleDefault];
    [toolbar setItems:aButtons animated:NO];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:toolbar];
    [toolbar release];
    return [barButton autorelease];
}

@end
