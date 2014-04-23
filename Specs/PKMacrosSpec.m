//
//  PKMacrosSpec.m
//  PKToolbox
//
//  Created by Pavel Kunc on 23/04/2014.
//

#import "Kiwi.h"
#import "PKMacros.h"

SPEC_BEGIN(PKMacrosSpecs)

describe(@"PK_NIL_IF_NULL", ^{

    it(@"should return NIL if argument is NIL", ^{
        id obj = nil;
        [[PK_NIL_IF_NULL(obj) should] beNil];
    });

    it(@"should return NIL if argument is NSNull", ^{
        id obj = [NSNull null];
        [[PK_NIL_IF_NULL(obj) should] beNil];
    });

    it(@"should return argument if argument is not NSNull or nil", ^{
        NSString *obj = @"blah";
        [[PK_NIL_IF_NULL(obj) should] equal:obj];
    });

});

describe(@"PK_NULL_IF_NIL", ^{

    it(@"should return NSNull if argument is NIL", ^{
        id obj = nil;
        [[PK_NULL_IF_NIL(obj) should] equal:[NSNull null]];
    });

    it(@"should return argument if argument is not nil", ^{
        id obj = @"blah";
        [[PK_NULL_IF_NIL(obj) should] equal:obj];

        obj = [NSNull null];
        [[PK_NULL_IF_NIL(obj) should] equal:obj];
    });

});

describe(@"PK_BOOL_TO_LOCALIZED_STRING", ^{

    it(@"should return localized YES if BOOL argument is YES", ^{
        NSString *value = PK_BOOL_TO_LOCALIZED_STRING(YES);
        [[value should] equal:NSLocalizedString(@"Yes", nil)];
    });

    it(@"should return localized NO if BOOL argument is NO", ^{
        NSString *value = PK_BOOL_TO_LOCALIZED_STRING(NO);
        [[value should] equal:NSLocalizedString(@"No", nil)];
    });

});

describe(@"PK_DEGREES_TO_RADIANS", ^{

    it(@"should return degrees for radians argument", ^{
        double degrees = PK_DEGREES_TO_RADIANS(0);
        [[theValue(degrees) should] equal:theValue(0)];

        degrees = PK_DEGREES_TO_RADIANS(90);
        [[theValue(degrees) should] equal:theValue(M_PI * 0.5)];

        degrees = PK_DEGREES_TO_RADIANS(180);
        [[theValue(degrees) should] equal:theValue(M_PI)];

        degrees = PK_DEGREES_TO_RADIANS(270);
        [[theValue(degrees) should] equal:theValue(M_PI * 1.5)];

        degrees = PK_DEGREES_TO_RADIANS(360);
        [[theValue(degrees) should] equal:theValue(M_PI * 2.0)];
    });

});

describe(@"PK_RADIANS_TO_DEGREES", ^{

    it(@"should return degrees for radians argument", ^{
        double degrees = PK_RADIANS_TO_DEGREES(0);
        [[theValue(degrees) should] equal:theValue(0)];

        degrees = PK_RADIANS_TO_DEGREES(M_PI * 0.5);
        [[theValue(degrees) should] equal:theValue(90)];

        degrees = PK_RADIANS_TO_DEGREES(M_PI);
        [[theValue(degrees) should] equal:theValue(180)];

        degrees = PK_RADIANS_TO_DEGREES(M_PI * 1.5);
        [[theValue(degrees) should] equal:theValue(270)];

        degrees = PK_RADIANS_TO_DEGREES(M_PI * 2.0);
        [[theValue(degrees) should] equal:theValue(360)];
    });

});

SPEC_END

