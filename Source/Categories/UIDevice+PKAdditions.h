//
//  UIDevice+PKAdditions.h
//  PKToolBox
//
//  Created by Pavel Kunc on 19/02/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

@import UIKit;
@import AdSupport;

@interface UIDevice (PKAdditions)

- (NSString *)pk_uniqueDeviceIdentifierSaltedWith:(NSString *)salt;
- (NSString *)pk_uniqueGlobalDeviceIdentifierSaltedWith:(NSString *)salt;

- (unsigned long long)pk_availableDiskSpace;
- (NSString *)pk_ipAddress;

@end
