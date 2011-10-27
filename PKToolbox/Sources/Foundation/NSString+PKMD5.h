//
//  NSString+PKMD5.h
//  PKToolbox
//
//  Created by Pavel Kunc on 27/10/2011.
//  Copyright 2011 Pavel Kunc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (PKMD5)

- (NSString *)pk_MD5Hash;

@end
