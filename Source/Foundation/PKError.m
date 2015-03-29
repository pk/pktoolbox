//
//  PKError.h
//  PKToolBox
//
//  Created by Pavel Kunc on 02/05/2012.
//  Copyright (c) 2012 Pavel Kunc. All rights reserved.
//

#import "PKError.h"

@implementation PKError

+ (NSString *)domain {
    return @"com.override.this.domain";
}

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
    return [self errorWithDomain:[[self class] domain] code:aCode description:aDescription];
}

+ (instancetype)errorWithCode:(NSInteger)aCode userInfo:(NSDictionary *)aDictionary {
    return [super errorWithDomain:[[self class] domain] code:aCode userInfo:aDictionary];
}

+ (instancetype)errorWithDomain:(NSString *)aDomain code:(NSInteger)aCode {
    return [self errorWithDomain:aDomain code:aCode description:nil];
}

+ (instancetype)errorWithDomain:(NSString *)aDomain
                           code:(NSInteger)aCode
                         format:(NSString *)aFormatString, ... {
    va_list args;
    va_start(args, aFormatString);
    NSString *description = [[NSString alloc] initWithFormat:aFormatString arguments:args];
    va_end(args);

    return [self errorWithDomain:aDomain code:aCode description:description];
}

+ (instancetype)errorWithDomain:(NSString *)aDomain
                           code:(NSInteger)aCode
                    description:(NSString *)aDescription {

    NSDictionary *info = nil;
    if (aDescription != nil) {
        info = [NSDictionary dictionaryWithObjectsAndKeys:aDescription,
                                                          NSLocalizedDescriptionKey,
                                                          nil];
    }

    return [super errorWithDomain:aDomain code:aCode userInfo:info];
}

@end

