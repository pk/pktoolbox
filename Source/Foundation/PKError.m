//
//  PKError.h
//  PKToolBox
//
//  Created by Pavel Kunc on 02/05/2012.
//  Copyright (c) 2012 Pavel Kunc. All rights reserved.
//

#import "PKError.h"

@implementation PKError

+ (instancetype)errorWithCode:(NSInteger)aCode {
    return [self errorWithCode:aCode description:nil];
}

+ (instancetype)errorWithCode:(NSInteger)aCode format:(NSString *)aFormatString, ... {
    va_list args;
    va_start(args, aFormatString);
    NSString *description = [[NSString alloc] initWithFormat:aFormatString arguments:args];
    va_end(args);

    return [self errorWithCode:aCode description:description];
}

+ (instancetype)errorWithCode:(NSInteger)aCode description:(NSString *)aDescription {
    NSDictionary *userInfo = nil;
    if (aDescription != nil) {
        userInfo = [NSDictionary dictionaryWithObjectsAndKeys:aDescription,
                                                              NSLocalizedDescriptionKey,
                                                              nil];
    }
    return [self errorWithCode:aCode userInfo:userInfo];
}

+ (instancetype)errorWithCode:(NSInteger)aCode userInfo:(NSDictionary *)aDictionary {
    return [super errorWithDomain:nil code:aCode userInfo:aDictionary];
}

- (instancetype)initWithDomain:(NSString *)aDomain
                          code:(NSInteger)aCode
                      userInfo:(NSDictionary *)aDictionary {
    return [super initWithDomain:[[self class] domain] code:aCode userInfo:aDictionary];
}

+ (NSString *)domain {
    return @"com.override.this.domain";
}

@end

