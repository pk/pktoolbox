//
//  PKMultiButtonBarButtonItem.h
//  PKToolbox
//
//  Created by Pavel Kunc on 02/05/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PKMultiButtonBarButtonItem : UIBarButtonItem { }

+ (UIBarButtonItem *)barButtonItemWithButtons:(UIBarButtonItem *)firstArg, ...  NS_REQUIRES_NIL_TERMINATION;
+ (UIBarButtonItem *)barButtonItemWithArray:(NSArray *)aArray;

@end
