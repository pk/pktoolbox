//
//  NSDateFormatter+PKStandardFormats.h
//  PKToolbox
//
//  Created by Pavel Kunc on 16/12/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz

#import "NSDateFormatter+PKStandardFormats.h"

static NSString const *rfc1123Format = @"EEE',' dd MMM yyyy HH':'mm':'ss z";
static NSString const *rfc850Format = @"EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z";
static NSString const *ansicFormat = @"EEE MMM d HH':'mm':'ss yyyy";
static NSString const *iso8601Format = @"yyyy-MM-dd'T'hh:mm:ss'Z'";


@implementation NSDateFormatter (PKStandardFormats)

+ (NSDateFormatter *)iso8601DateFormatter {
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    df.timeStyle = NSDateFormatterFullStyle;
    df.dateFormat = @"yyyy-MM-dd'T'hh:mm:ss'Z'";
    return df;
}

+ (NSDateFormatter *)rfc2616DateFormatterWithFormat:(NSString *)aFormat {
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    df.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    df.dateFormat = aFormat;
    return df;
}

@end

