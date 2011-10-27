//
//  NSString+PKMD5.h
//  PKToolbox
//
//  Created by Pavel Kunc on 27/10/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

#import "NSString+PKMD5.h"

@implementation NSString (PKMD5)

- (NSString *)pk_MD5Hash {
    if ([self length] == 0) return nil;

    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return (NSString *)ret;
}

@end
