//
//  UIColor+PKAdditionsSpec.m
//  UIColor+PKAdditions Spec
//
//  Created by Pavel Kunc on 04/11/2013.
//

#import "Kiwi.h"
#import "UIColor+PKAdditions.h"

SPEC_BEGIN(UIColor_PKAdditionsSpec)

describe(@"pk_colorWithHexRGBA", ^{

    context(@"when given hex RGBA color value", ^{
        it(@"should return UIColor object of that color", ^{
            NSUInteger red = 0xFF0000FF;
            UIColor *redColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
            [[[UIColor pk_colorWithHexRGBA:red] should] equal:redColor];
        });
    });

});

SPEC_END

