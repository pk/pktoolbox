//
//  NSDate+PKStandardFormats.m
//  PKToolbox
//
//  Created by Pavel Kunc on 16/12/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz

#import "NSDate+PKStandardFormats.h"
#import "NSDateFormatter+PKStandardFormats.h"


@implementation NSDate (PKStandardFormats)


#pragma mark - Date -> String

- (NSString *)iso8601String {
    static NSDateFormatter *df = nil;
    if(df == nil) {
        df = [[NSDateFormatter iso8601DateFormatter] retain];
    }
    return [df stringFromDate:self];
}

- (NSString *)rfc2616String {
    static NSDateFormatter *df = nil;
    if(df == nil) {
        df = [NSDateFormatter rfc2616DateFormatterWithFormat:rfc1123Format];
    }
    return [df stringFromDate:self];
}


#pragma mark - String -> Date

+ (NSDate *)dateFromISO8601:(NSString *)aDate {
    if(aDate == nil) return nil;
    static NSDateFormatter *df = nil;
    if(df == nil) {
        df = [[NSDateFormatter iso8601DateFormatter] retain];
    }
    return [df dateFromString:aDate];
}

+ (NSDate *)dateFromRFC2616:(NSString *)aDate {
    NSDate *date = [NSDate dateFromRFC1123:aDate];
    if (date) return date;
    date = [NSDate dateFromRFC850:aDate];
    if (date) return date;
    return [NSDate dateFromANSIC:aDate];
}

+ (NSDate *)dateFromRFC1123:(NSString *)aDate {
    if(aDate == nil) return nil;
    static NSDateFormatter *df = nil;
    if(df == nil) {
        df = [NSDateFormatter rfc2616DateFormatterWithFormat:rfc1123Format];
    }
    return [df dateFromString:aDate];
}

+ (NSDate *)dateFromRFC850:(NSString *)aDate {
    if(aDate == nil) return nil;
    static NSDateFormatter *df = nil;
    if(df == nil) {
        df = [NSDateFormatter rfc2616DateFormatterWithFormat:rfc850Format];
    }
    return [df dateFromString:aDate];
}

+ (NSDate *)dateFromANSIC:(NSString *)aDate {
    if(aDate == nil) return nil;
    static NSDateFormatter *df = nil;
    if(df == nil) {
        df = [NSDateFormatter rfc2616DateFormatterWithFormat:ansicFormat];
    }
    return [df dateFromString:aDate];
}

@end

