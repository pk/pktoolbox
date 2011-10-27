//
//  UIDevice+PKUniqueIdentifier.h
//  PKToolbox
//
//  Created by Pavel Kunc on 27/10/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (PKUniqueIdentifier)

- (NSString *)pk_saltedDeviceUniqueIdentifier:(NSString *)aSaltOrNil;
- (NSString *)pk_deviceUniqueIdentifier;

@end
