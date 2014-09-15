//
//  PKGCDTimerSpec.m
//  PKToolbox
//
//  Created by Pavel Kunc on 23/04/2014.
//

#define EXP_SHORTHAND
#import "Expecta.h"
#import "Specta.h"
#import "PKGCDTimer.h"

SpecBegin(PKGCDTimerSpecs)

describe(@"PKGCDTimer", ^{

    context(@"perform task with delay", ^{
        it(@"should perform task after specified delay passes", ^{
            __block NSString *done = nil;

            PKGCDTimer *timer = [PKGCDTimer new];
            [timer performBlock:^{ done = @"yep"; } withDelay:1.0];
            expect(done).after(2.0).will.equal(@"yep");
        });
    });

    context(@"perform task periodically", ^{
        it(@"should perform task every time interval until invalidated", ^{
            __block NSUInteger count = 1;

            PKGCDTimer *timer = [PKGCDTimer new];
            [timer performBlock:^{ count++; } every:1.0];
            expect(count).after(2.0).will.equal(3);
        });

    });

});

SpecEnd
