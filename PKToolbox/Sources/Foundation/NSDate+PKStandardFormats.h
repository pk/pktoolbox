//
//  NSDate+PKStandardFormats.h
//  PKToolbox
//
//  Created by Pavel Kunc on 16/12/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz

@interface NSDate (PKStandardFormats)

/**
 * Convert NSDate into a RFC1123 'Full-Date' string
 * (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1).
 */
- (NSString *)rfc2616String;

- (NSString *)iso8601String;

+ (NSDate *)dateFromISO8601:(NSString *)aDate;

/**
 * Convert a 'Full-Date' string
 * (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1)
 * into NSDate.
 */
+ (NSDate *)dateFromRFC2616:(NSString *)aDate;

/**
 * Convert a RFC1123 string
 * (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1)
 * into NSDate.
 */
+ (NSDate *)dateFromRFC1123:(NSString *)aDate;

/**
 * Convert a RFC850 string
 * (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1)
 * into NSDate.
 */
+ (NSDate *)dateFromRFC850:(NSString *)aDate;

/**
 * Convert a ANSI C string
 * (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1)
 * into NSDate.
 */
+ (NSDate *)dateFromANSIC:(NSString *)aDate;

@end

