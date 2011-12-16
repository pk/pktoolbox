//
//  NSDateFormatter+PKStandardFormats.h
//  PKToolbox
//
//  Created by Pavel Kunc on 16/12/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz

extern static NSString const *rfc1123Format;
extern static NSString const *rfc850Format;
extern static NSString const *ansicFormat;
extern static NSString const *iso8601Format;


@interface NSDateFormatter (PKStandardFormats)

+ (NSDateFormatter *)iso8601DateFormatter {
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    df.timeStyle = NSDateFormatterFullStyle;
    df.dateFormat = iso8601Format;
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

