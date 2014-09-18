//
//  UIDevice+PKAdditions.m
//  PKToolBox
//
//  Created by Pavel Kunc on 19/02/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

#import "UIDevice+PKAdditions.h"

@implementation UIDevice (PKAdditions)


#pragma mark - Device identifier generation

- (NSString *)pk_uniqueDeviceIdentifierSaltedWith:(NSString *)aSalt {
    NSString *identifier =
        [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];

    identifier =
        [identifier stringByAppendingString:[[NSBundle mainBundle] bundleIdentifier]];

    if (aSalt != nil && [aSalt length] > 0) {
        identifier = [identifier stringByAppendingString:aSalt];
    }

    return [identifier pk_SHA1_Base64];
}

- (NSString *)pk_uniqueGlobalDeviceIdentifierSaltedWith:(NSString *)aSalt {
    NSString *identifier =
        [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];

    if (aSalt != nil && [aSalt length] > 0) {
        identifier = [identifier stringByAppendingString:aSalt];
    }

    return [identifier pk_SHA1_Base64];
}

- (NSString *)pk_ipAddress {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;

    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0

                if([name isEqualToString:@"en0"]) {
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }

        // Free memory
        freeifaddrs(interfaces);
    }

    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
}

- (unsigned long long)pk_availableDiskSpace {
    unsigned long long totalSpace = 0;
    unsigned long long totalFreeSpace = 0;

    NSError * __autoreleasing error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary =
        [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject]
                                                                error:&error];
    if (dictionary) {
        totalSpace = [dictionary[NSFileSystemSize] unsignedLongLongValue];
        totalFreeSpace = [dictionary[NSFileSystemFreeSize] unsignedLongLongValue];
        NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.",
              ((totalSpace/1024ll)/1024ll),
              ((totalFreeSpace/1024ll)/1024ll));
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %d",
              [error domain],
              [error code]);
    }

    return totalFreeSpace;
}

@end
