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

- (id)pk_stringByReplacingNumericHTMLEntities {
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

@end
