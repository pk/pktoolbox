//
//  UIButton+PKAdditions.h
//  PKToolBox
//
//  Created by Pavel Kunc on 17/01/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

@import UIKit.UIButton;

@interface UIButton (PKAdditions)

+ (instancetype)pk_buttonWithImage:(UIImage *)image
                            target:(id)target
                            action:(SEL)action;

@end
