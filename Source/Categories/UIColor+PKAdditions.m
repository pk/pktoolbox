//
//  UIColor+PKAdditions.m
//  PKToolBox
//
//  Created by Pavel Kunc on 01/05/2012.
//  Copyright (c) 2012 Pavel Kunc. All rights reserved.
//

#import "UIColor+PKAdditions.h"

@implementation UIColor (PKAdditions)

+ (id)pk_colorWithHexRGBA:(NSUInteger)aColor {
    return [UIColor colorWithRed:((aColor >> 24) & 0xFF) / 255.0
                           green:((aColor >> 16) & 0xFF) / 255.0
                            blue:((aColor >> 8) & 0xFF) / 255.0
                           alpha:(aColor & 0xFF) / 255.0];
}

@end
