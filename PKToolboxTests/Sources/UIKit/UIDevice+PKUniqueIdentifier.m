//
//  UIDevice+PKUniqueIdentifier.m
//  PKToolbox
//
//  Created by Pavel Kunc on 27/10/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

#import "UIDevice+PKUniqueIdentifier.h"

@interface UIDevicePKUniqueIdentifierTest : SenTestCase {}
@end


@implementation UIDevicePKUniqueIdentifierTest

#pragma mark - pk_deviceUniqueIdentifier

- (void)testDeviceUniqueIdentifierReturnsUniqueString {
    NSString *first = [[UIDevice currentDevice] pk_deviceUniqueIdentifier];
    NSString *second = [[UIDevice currentDevice] pk_deviceUniqueIdentifier];
    assertThat(first, equalTo(second));
}

#pragma mark - pk_saltedDeviceUniqueIdentifier

- (void)testSaltedDeviceUniqueIdentifierWithoutSaltReturnsDeviceUniqueIdentifier {
    NSString *dui = [[UIDevice currentDevice] pk_deviceUniqueIdentifier];
    NSString *sdui = [[UIDevice currentDevice] pk_saltedDeviceUniqueIdentifier:nil];
    assertThat(sdui, equalTo(dui));
}

- (void)testSaltedDeviceUniqueIdentifierWithEmptySaltReturnsDeviceUniqueIdentifier {
    NSString *dui = [[UIDevice currentDevice] pk_deviceUniqueIdentifier];
    NSString *sdui = [[UIDevice currentDevice] pk_saltedDeviceUniqueIdentifier:@""];
    assertThat(sdui, equalTo(dui));
}

- (void)testSaltedDeviceUniqueIdentifierWithSaltReturnsUniqueString {
    NSString *dui = [[UIDevice currentDevice] pk_deviceUniqueIdentifier];
    NSString *sdui = [[UIDevice currentDevice] pk_saltedDeviceUniqueIdentifier:@"bundle-identifier"];
    assertThat(sdui, isNot(equalTo(dui)));
}

@end

