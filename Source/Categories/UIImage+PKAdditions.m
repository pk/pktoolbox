//
//  UIImage+PKAdditions.m
//  PKToolBox
//
//  Created by Pavel Kunc on 20/01/2013.
//  Copyright (c) 2013 Pavel Kunc. All rights reserved.
//

#import "UIImage+PKAdditions.h"
#import "PKMacros.h"

static NSString * const kWideScreenFilenameSuffix = @"-568h";

@implementation UIImage (PKAdditions)

// TODO: This doesn't handle non -568h files so it can't be used all the time
+ (UIImage *)pk_imageNamed:(NSString *)aName {
    NSParameterAssert(aName);

    if (!PK_IS_IPHONE_5) return [self imageNamed:aName];

    NSString *name;
    NSString *extension = [aName pathExtension];
    if ([extension length] == 0) {
        name = [aName stringByAppendingString:kWideScreenFilenameSuffix];
    } else {
        NSString *baseName = [aName stringByDeletingPathExtension];
        name = [baseName stringByAppendingString:kWideScreenFilenameSuffix];
        name = [name stringByAppendingString:extension];
    }
    return [self imageNamed:name];
}

@end
