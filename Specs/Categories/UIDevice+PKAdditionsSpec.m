//
//  UIDevice+PKAdditionsSpec.m
//  UIDevice+PKAdditions Spec
//
//  Created by Pavel Kunc on 04/11/2013.
//

#import "UIDevice+PKAdditions.h"

#define EXP_SHORTHAND
#import "Expecta.h"
#import <Specta/Specta.h>
#import "UIDevice+PKAdditions.h"

SpecBegin(UIDevice_PKAdditions)

describe(@"pk_uniqueDeviceIdentifierSaltedWith:", ^{

    it(@"should return unsalted unique identifier of the device when no salt is passed", ^{
        UIDevice *device = [UIDevice currentDevice];
        expect([device pk_uniqueDeviceIdentifierSaltedWith:nil]).notTo.beNil();
    });

    it(@"should return salted unique identifier of the device when salt is passed", ^{
        UIDevice *device = [UIDevice currentDevice];
        expect([device pk_uniqueDeviceIdentifierSaltedWith:@"salt"]).notTo.beNil();
    });

    it(@"should return different identifier when salted and unsalted", ^{
        UIDevice *device = [UIDevice currentDevice];
        NSString *unsalted = [device pk_uniqueDeviceIdentifierSaltedWith:nil];
        NSString *salted = [device pk_uniqueDeviceIdentifierSaltedWith:@"salt"];
        expect(salted).notTo.equal(unsalted);
    });

});

describe(@"pk_ipAddress", ^{

    it(@"should return IP address if it is possible to get one", ^{
        expect([[UIDevice currentDevice] pk_ipAddress]).notTo.beNil();
    });

    it(@"should return 0.0.0.0 as IP address if it is not possible", ^{
        //expect([[UIDevice currentDevice] pk_ipAddress]).equal(@"0.0.0.0");
    });

});

describe(@"pk_availableDiskSpace", ^{

    it(@"should return available space in bytes", ^{
        expect([[UIDevice currentDevice] pk_availableDiskSpace]).beGreaterThan(0);
    });

});

SpecEnd

