//
//  PKDurationFormatterSpec.m
//  PKToolbox
//
//  Created by Pavel Kunc on 23/04/2014.
//

#define EXP_SHORTHAND
#import "Expecta.h"
#import "Specta.h"
#import "PKDurationFormatter.h"

SpecBegin(PKDurationFormatterSpec)

describe(@"PKDurationFormatter", ^{
    __block PKDurationFormatter *_formatter = nil;

    beforeAll(^{
        _formatter = [[PKDurationFormatter alloc] init];
    });

    afterAll(^{
        _formatter = nil;
    });

    it(@"should format 0.0 duration to 00:00.00 string", ^{
        expect([_formatter stringFromNumber:0.0]).equal(@"00:00.00");
    });

    it(@"should format 0.11 duration to 00:00.11 string", ^{
        expect([_formatter stringFromNumber:0.11]).equal(@"00:00.11");
    });

    it(@"should format 0.99 duration to 00:00.99 string", ^{
        expect([_formatter stringFromNumber:0.99]).equal(@"00:00.99");
    });

    it(@"should format 59.11 duration to 00:59.11 string", ^{
        expect([_formatter stringFromNumber:59.11]).equal(@"00:59.11");
    });

    it(@"should format 60.11 duration to 01:00.11 string", ^{
        expect([_formatter stringFromNumber:60.11]).equal(@"01:00.11");
    });

});

SpecEnd
