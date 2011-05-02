//
//  PKNavigationItem.m
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz
//

#import "PKNavigationItem.h"
#import "PKMultiButtonBarButtonItem.h"

@implementation PKNavigationItem


#pragma mark - Init/Memory management

- (id)initWithTitle:(NSString *)aTitle {
    return [super initWithTitle:aTitle];
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark - Left buttons management

//- (void)addLeftButton:(UIBarButtonItem *)aButton {}
//- (UIBarButtonItem *)removeLeftButton:(UIBarButtonItem *)aButton {}

- (void)setLeftButtons:(UIBarButtonItem *)firstArg, ... {
    NSMutableArray *buttons = [[NSMutableArray alloc] init];

    va_list args;
    va_start(args, firstArg);
    for (UIBarButtonItem *arg = firstArg; arg != nil; arg = va_arg(args, UIBarButtonItem*)) {
        [buttons addObject:arg];
    }
    va_end(args);

    [self setLeftButtonsWithArray:buttons];
    [buttons release];
}

- (void)setLeftButtonsWithArray:(NSArray *)aButtons {
    UIBarButtonItem *item = [PKMultiButtonBarButtonItem barButtonItemWithArray:aButtons];
    [self setLeftBarButtonItem:item animated:NO];
}


#pragma mark - Right buttons management

//- (void)addRightButton:(UIBarButtonItem *)aButton {}
//- (UIBarButtonItem *)removeRightButton:(UIBarButtonItem *)aButton {}

- (void)setRightButtons:(UIBarButtonItem *)firstArg, ... {
    NSMutableArray *buttons = [[NSMutableArray alloc] init];

    va_list args;
    va_start(args, firstArg);
    for (UIBarButtonItem *arg = firstArg; arg != nil; arg = va_arg(args, UIBarButtonItem*)) {
        [buttons addObject:arg];
    }
    va_end(args);

    [self setRightButtonsWithArray:buttons];
    [buttons release];
}

- (void)setRightButtonsWithArray:(NSArray *)aButtons {
    UIBarButtonItem *item = [PKMultiButtonBarButtonItem barButtonItemWithArray:aButtons];
    [self setRightBarButtonItem:item animated:NO];
}

@end

