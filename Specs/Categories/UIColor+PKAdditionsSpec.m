//
//  UIColor+PKAdditionsSpec.m
//  UIColor+PKAdditions Spec
//
//  Created by Pavel Kunc on 04/11/2013.
//

#define EXP_SHORTHAND
#import "Expecta.h"
#import "Specta.h"
#import "UIColor+PKAdditions.h"

SpecBegin(UIColor_PKAdditionsSpec)

describe(@"pk_colorWithHexRGBA", ^{

    context(@"when given hex RGBA color value", ^{
        it(@"should return UIColor object of that color", ^{
            NSUInteger red = 0xFF0000FF;
            UIColor *redColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
            expect([UIColor pk_colorWithHexRGBA:red]).equal(redColor);
        });
    });

});

SpecEnd

