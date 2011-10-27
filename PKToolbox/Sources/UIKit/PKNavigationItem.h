//
//  PKNavigationItem.h
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz
//

#import <UIKit/UIKit.h>


@interface PKNavigationItem : UINavigationItem { }

//- (void)addLeftButton:(UIBarButtonItem *)aButton;
//- (UIBarButtonItem *)removeLeftButton:(UIBarButtonItem *)aButton;
- (void)setLeftButtons:(UIBarButtonItem *)firstArg, ... NS_REQUIRES_NIL_TERMINATION;
- (void)setLeftButtonsWithArray:(NSArray *)aButtons;

//- (void)addRightButton:(UIBarButtonItem *)aButton;
//- (UIBarButtonItem *)removeRightButton:(UIBarButtonItem *)aButton;
- (void)setRightButtons:(UIBarButtonItem *)firstArg, ... NS_REQUIRES_NIL_TERMINATION;
- (void)setRightButtonsWithArray:(NSArray *)aButtons;

@end
