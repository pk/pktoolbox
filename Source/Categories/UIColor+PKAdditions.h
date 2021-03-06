//
//  UIColor+PKAdditions.h
//  PKToolBox
//
//  Created by Pavel Kunc on 01/05/2012.
//  Copyright (c) 2012 Pavel Kunc. All rights reserved.
//

@import UIKit.UIColor;

@interface UIColor (PKAdditions)

+ (instancetype)pk_colorWithHexRGBA:(NSUInteger)color;


+ (instancetype)pk_colorWithColor:(UIColor *)color
             brightnessAdjustment:(CGFloat)adjustment;

- (UIColor *)pk_colorWithBrightnessAdjustment:(CGFloat)adjustment;


@end
