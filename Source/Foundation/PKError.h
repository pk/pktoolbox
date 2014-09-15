//
//  PKError.h
//  PKToolBox
//
//  Created by Pavel Kunc on 02/05/2012.
//  Copyright (c) 2012 Pavel Kunc. All rights reserved.
//

@import Foundation;

@interface PKError : NSError

+ (instancetype)errorWithCode:(NSInteger)code;
+ (instancetype)errorWithCode:(NSInteger)code format:(NSString *)format, ...;
+ (instancetype)errorWithCode:(NSInteger)code description:(NSString *)description;
+ (instancetype)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict;

+ (NSString *)domain;

@end

