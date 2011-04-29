//
//  PKNavigationItem.m
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "PKNavigationItem.h"

@interface PKNavigationItem ()
@property (nonatomic, retain, readwrite) NSMutableArray *leftButtons;
@property (nonatomic, retain, readwrite) NSMutableArray *rightButtons;
@end

@implementation PKNavigationItem

@synthesize leftButtons = leftButtons_;
@synthesize rightButtons = rightButtons_;

#pragma mark - Init/Memory management

- (id)initWithTitle:(NSString *)aTitle {
    if ((self = [super initWithTitle:aTitle])) {
        leftButtons_ = [[NSMutableArray alloc] init];
        rightButtons_ = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [leftButtons_ release];
    [rightButtons_ release];
    [super dealloc];
}


#pragma mark - Left buttons management

- (void)addLeftButton:(UIBarButtonItem *)aButton {}
- (UIBarButtonItem *)removeLeftButton:(UIBarButtonItem *)aButton {}

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
    UIBarButtonItem *item = [self barButtonItemWithArray:aButtons];
    [self setLeftBarButtonItem:item animated:NO];
}


#pragma mark - Right buttons management

- (void)addRightButton:(UIBarButtonItem *)aButton {}
- (UIBarButtonItem *)removeRightButton:(UIBarButtonItem *)aButton {}
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
    UIBarButtonItem *item = [self barButtonItemWithArray:aButtons];
    [self setRightBarButtonItem:item animated:NO];
}


#pragma mark - Creating bar button toolbars

- (UIBarButtonItem *)barButtonItemWithButtons:(UIBarButtonItem *)firstArg, ... {
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

- (UIBarButtonItem *)barButtonItemWithArray:(NSArray *)aButtons {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    toolbar.translucent = YES;
    [toolbar setItems:aButtons animated:NO];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:toolbar];
    [toolbar release];
    return [barButton autorelease];
}

@end

