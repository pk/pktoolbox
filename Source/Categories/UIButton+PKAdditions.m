//
//  UIButton+PKAdditions.h
//  PKToolBox
//
//  Created by Pavel Kunc on 17/01/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

#import "UIButton+PKAdditions.h"

@implementation UIButton (PKAdditions)

+ (instancetype)pk_buttonWithImage:(UIImage *)aImage
                            target:(id)aTarget
                            action:(SEL)aAction {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:aImage forState:UIControlStateNormal];
    [button addTarget:aTarget
               action:aAction
     forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return button;
}

@end
