//
//  PKError.h
//  PKToolBox
//
//  Created by Pavel Kunc on 02/05/2012.
//  Copyright (c) 2012 Pavel Kunc. All rights reserved.
//

@import Foundation;

#ifndef PK_ERROR_PROJECT_DOMAIN
#define PK_ERROR_PROJECT_DOMAIN @"PKErrorDomain"
#endif

@interface PKError : NSError

+ (instancetype)errorWithCode:(NSInteger)code;
+ (instancetype)errorWithCode:(NSInteger)code format:(NSString *)format, ...;
+ (instancetype)errorWithCode:(NSInteger)code description:(NSString *)description;
+ (instancetype)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict;

@end

