//
//  NSString+PKAdditions.h
//  PKToolBox
//
//  Created by Pavel Kunc on 21/10/2013.
//  Copyright (c) 2013 Pavel Kunc. All rights reserved.
//

#import "NSString+PKAdditions.h"

static NSString * const kEntityStart = @"&#";
static NSString * const kEntityEnd = @";";


@implementation NSString (PKAdditions)

//TODO: This only handles decimal HTML entity codes but not hexa &#xDDDD;
//      (pavel, Mon  4 Nov 20:39:27 2013)
- (instancetype)pk_stringByReplacingNumericHTMLEntities {
    NSString *string = [self copy];

    NSRange entityEnd;
    NSRange entityStart = [string rangeOfString:kEntityStart];
    while (entityStart.location != NSNotFound) {
        NSRange reminder = NSMakeRange(entityStart.location, [string length] - entityStart.location);
        entityEnd = [string rangeOfString:kEntityEnd options:0 range:reminder];

        NSRange numberRange = NSMakeRange(NSMaxRange(entityStart),
                                          entityEnd.location - NSMaxRange(entityStart));
        unichar uniChar = [[string substringWithRange:numberRange] integerValue];
        NSString *quoteStr = [NSString stringWithCharacters:&uniChar length:1];

        NSRange entityRange = NSUnionRange(entityStart, entityEnd);
        string = [string stringByReplacingCharactersInRange:entityRange withString:quoteStr];
        entityStart = [string rangeOfString:kEntityStart];
    }

    return string;
}

- (instancetype)pk_SHA1_Base64 {
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (CC_SHA1([stringBytes bytes], (uint)[stringBytes length], digest) != digest) return nil;

    NSData *sha = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    return [sha base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end

