//
//  UIColor+PKAdditions.m
//  PKToolBox
//
//  Created by Pavel Kunc on 01/05/2012.
//  Copyright (c) 2012 Pavel Kunc. All rights reserved.
//

#import "UIColor+PKAdditions.h"

@implementation UIColor (PKAdditions)

+ (instancetype)pk_colorWithHexRGBA:(NSUInteger)aColor {
    return [UIColor colorWithRed:((aColor >> 24) & 0xFF) / 255.0
                           green:((aColor >> 16) & 0xFF) / 255.0
                            blue:((aColor >> 8) & 0xFF) / 255.0
                           alpha:(aColor & 0xFF) / 255.0];
}

+ (instancetype)pk_colorWithColor:(UIColor *)aColor
             brightnessAdjustment:(CGFloat)aAdjustment {
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    [aColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

    brightness = brightness + aAdjustment;
    brightness = aAdjustment > 0.0 ? MIN(1.0, brightness) : MAX(0.0, brightness);

    UIColor *color = [UIColor colorWithHue:hue
                                saturation:saturation
                                brightness:brightness
                                     alpha:alpha];
    return color;
}

- (UIColor *)pk_colorWithBrightnessAdjustment:(CGFloat)aAdjustment {
    return [[self class] pk_colorWithColor:self brightnessAdjustment:aAdjustment];
}

@end
