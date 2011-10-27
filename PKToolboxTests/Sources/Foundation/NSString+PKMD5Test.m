//
//  NSString+PKMD5Test.m
//  PKToolbox
//
//  Created by Pavel Kunc on 27/10/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

#import "NSString+PKMD5.h"

@interface NSStringPKMD5 : SenTestCase {}
@end


@implementation NSStringPKMD5

#pragma mark - pk_MD5Hash

- (void)testMD5HashCalcualtesCorrectMD5 {
    NSString *str = @"ABCD";
    assertThat([str pk_MD5Hash], equalTo(@"cb08ca4a7bb5f9683c19133a84872ca7"));
}

- (void)testMD5HashReturnsNilForEmptyString {
    NSString *str = @"";
    assertThat([str pk_MD5Hash], nilValue());
}

@end

