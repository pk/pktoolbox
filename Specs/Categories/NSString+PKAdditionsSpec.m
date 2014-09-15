//
//  NSString+PKAdditionsSpec.m
//  NSString+PKAdditions Spec
//
//  Created by Pavel Kunc on 04/11/2013.
//

#define EXP_SHORTHAND
#import "Expecta.h"
#import "Specta.h"
#import "NSString+PKAdditions.h"

SpecBegin(NSString_PKAdditionsSpec)

describe(@"pk_stringByReplacingNumericHTMLEntities", ^{

    context(@"when given string without any HTML entities", ^{
        it(@"should return the unchanged string", ^{
            NSString *original = @"Lorem ipsum...";
            expect(original).equal([original pk_stringByReplacingNumericHTMLEntities]);
        });
    });

    context(@"when given empty string", ^{
        it(@"should return empty string", ^{
            expect(@"").equal([@"" pk_stringByReplacingNumericHTMLEntities]);
        });
    });


    // http://www.fileformat.info/info/unicode/char/2018/index.htm
    // http://www.fileformat.info/info/unicode/char/2019/index.htm
    context(@"when given string with HTML entities", ^{
        it(@"should return the string with all entities converted to characters", ^{
            NSString *original = @"Lorem &#8216;ipsum&#8217;...";
            NSString *result = @"Lorem ‘ipsum’...";
            expect([original pk_stringByReplacingNumericHTMLEntities]).equal(result);
        });
    });

});

describe(@"pk_SHA1_Base64", ^{

    context(@"when string is empty", ^{
        it(@"should return SHA1 special value for empty string", ^{
            // Digest::SHA1.hexdigest('') => "da39a3ee5e6b4b0d3255bfef95601890afd80709"
            // Digest::SHA1.base64digest('') => "2jmj7l5rSw0yVb/vlWAYkK/YBwk="
            expect([@"" pk_SHA1_Base64]).equal(@"2jmj7l5rSw0yVb/vlWAYkK/YBwk=");
        });
    });

    context(@"when string is not empty", ^{
        it(@"should return Base64 representation of the SHA1 of the string", ^{
            NSString *string = @"abcdefghijklmnopqrstuvwxyz";
            NSString *hash = @"MtEMe4z5ZXDKBM438qGdhCQNOok=";
            expect([string pk_SHA1_Base64]).equal(hash);
        });
    });

});

SpecEnd

