//
//  UIDevice+PKAdditions.h
//  PKToolBox
//
//  Created by Pavel Kunc on 19/02/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

@import UIKit.UIDevice;
@import Darwin.POSIX.arpa.inet;
@import AdSupport.ASIdentifierManager;

#import "NSString+PKAdditions.h"
#import <ifaddrs.h>

/**
 * Utilities related to the device information
 */
@interface UIDevice (PKAdditions)

/**
 * Unique identifier for the device AND the app.
 *
 * It is based on the ASIdentifierManager#advertisingIdentifier but combines
 * it with the app identifier.
 *
 * @param salt Optional string to salt the identifier
 * @return Unique ID in Base64
 */
- (NSString *)pk_uniqueDeviceIdentifierSaltedWith:(NSString *)salt;

/**
 * Unique identifier for the device
 *
 * It is based on the ASIdentifierManager#advertisingIdentifier.
 *
 * @param salt Optional string to salt the identifier
 * @return Unique ID in Base64
 */
- (NSString *)pk_uniqueGlobalDeviceIdentifierSaltedWith:(NSString *)salt;

/**
 * Gets the available disk space
 *
 * @return Disk space in bytes
 */
- (unsigned long long)pk_availableDiskSpace;

/**
 * Gets IP address from the en0 or pdp_ip0 (cellular)
 *
 * @return IP address or 0.0.0.0
 */
- (NSString *)pk_ipAddress;

/**
 * Gets device name which is safe to use as filename.
 *
 * Replaces all non-alphanumeric characters with underscore (_)
 *
 * @return Sanitized device name
 */
- (NSString *)pk_sanitizedName;

@end
