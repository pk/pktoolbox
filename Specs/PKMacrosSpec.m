//
//  PKMacrosSpec.m
//  PKToolbox
//
//  Created by Pavel Kunc on 23/04/2014.
//

#define EXP_SHORTHAND
#import "Expecta.h"
#import "Specta.h"
#import "PKMacros.h"

SpecBegin(PKMacrosSpecs)

describe(@"PK_NIL_IF_NULL", ^{

    it(@"should return NIL if argument is NIL", ^{
        expect(PK_NIL_IF_NULL(nil)).beNil;
    });

    it(@"should return NIL if argument is NSNull", ^{
        expect(PK_NIL_IF_NULL([NSNull null])).beNil;
    });

    it(@"should return argument if argument is not NSNull or nil", ^{
        NSString *obj = @"blah";
        expect(PK_NIL_IF_NULL(obj)).equal(obj);
    });

});

describe(@"PK_NULL_IF_NIL", ^{

    it(@"should return NSNull if argument is NIL", ^{
        expect(PK_NULL_IF_NIL(nil)).equal([NSNull null]);
    });

    it(@"should return argument if argument is not nil", ^{
        id obj = @"blah";
        expect(PK_NULL_IF_NIL(obj)).equal(obj);

        obj = [NSNull null];
        expect(PK_NULL_IF_NIL(obj)).equal(obj);
    });

});

describe(@"PK_BOOL_TO_LOCALIZED_STRING", ^{

    it(@"should return localized YES if BOOL argument is YES", ^{
        NSString *value = PK_BOOL_TO_LOCALIZED_STRING(YES);
        expect(NSLocalizedString(@"Yes", nil)).equal(value);
    });

    it(@"should return localized NO if BOOL argument is NO", ^{
        NSString *value = PK_BOOL_TO_LOCALIZED_STRING(NO);
        expect(NSLocalizedString(@"No", nil)).equal(value);
    });

});

describe(@"PK_DEGREES_TO_RADIANS", ^{

    it(@"should return degrees for radians argument", ^{
        expect(PK_DEGREES_TO_RADIANS(0)).equal(0);
        expect(PK_DEGREES_TO_RADIANS(90)).equal(M_PI * 0.5);
        expect(PK_DEGREES_TO_RADIANS(180)).equal(M_PI);
        expect(PK_DEGREES_TO_RADIANS(270)).equal(M_PI * 1.5);
        expect(PK_DEGREES_TO_RADIANS(360)).equal(M_PI * 2.0);
    });

});

describe(@"PK_RADIANS_TO_DEGREES", ^{

    it(@"should return degrees for radians argument", ^{
        expect(PK_RADIANS_TO_DEGREES(0)).equal(0);
        expect(PK_RADIANS_TO_DEGREES(M_PI * 0.5)).equal(90);
        expect(PK_RADIANS_TO_DEGREES(M_PI)).equal(180);
        expect(PK_RADIANS_TO_DEGREES(M_PI * 1.5)).equal(270);
        expect(PK_RADIANS_TO_DEGREES(M_PI * 2.0)).equal(360);
    });

});

SpecEnd

