//
//  UIDevice+PKUniqueIdentifier.m
//  PKToolbox
//
//  Created by Pavel Kunc on 27/10/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

#import "UIDevice+PKUniqueIdentifier.h"
#import "NSString+PKMD5.h"
#import "UIDevice-Hardware.h" // Erica Sadun's category

@implementation UIDevice (PKUniqueIdentifier)

- (NSString *)pk_saltedDeviceUniqueIdentifier:(NSString *)aSaltOrNil {
    NSString *uid = [self pk_deviceUniqueIdentifier];

    if (aSaltOrNil == nil || [aSaltOrNil length] == 0) {
        aSaltOrNil = [[NSBundle mainBundle] bundleIdentifier];
    }
    if (aSaltOrNil != nil) {
        uid = [[uid stringByAppendingString:aSaltOrNil] pk_MD5Hash];
    }

    return uid;
}

- (NSString *)pk_deviceUniqueIdentifier {
    NSString *mac = [self macaddress];
    return [mac pk_MD5Hash];
}

@end
