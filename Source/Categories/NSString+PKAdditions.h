//
//  NSString+PKAdditions.h
//  PKToolBox
//
//  Created by Pavel Kunc on 21/10/2013.
//  Copyright (c) 2013 Pavel Kunc. All rights reserved.
//

@import Foundation;
#import <CommonCrypto/CommonDigest.h>

@interface NSString (PKAdditions)

- (instancetype)pk_stringByReplacingNumericHTMLEntities;
- (instancetype)pk_SHA1_Base64;

@end
