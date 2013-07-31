//
//  NSString+PKUUID.m
//  PKToolbox
//
//  Created by Pavel Kunc on 21/05/2012.
//  Copyright (c) 2012 Fry-it, Limited. All rights reserved.
//

#import "NSString+PKUUID.h"

@implementation NSString (PKUUID)

+ (NSString *)pk_UUID {
  CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
  NSString *str = (NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
  CFRelease(uuid);
  [str autorelease];
  return str;
}

@end
