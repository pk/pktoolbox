//
//  NSDateFormatter+PKStandardFormats.h
//  PKToolbox
//
//  Created by Pavel Kunc on 16/12/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz

extern NSString const *rfc1123Format;
extern NSString const *rfc850Format;
extern NSString const *ansicFormat;
extern NSString const *iso8601Format;


@interface NSDateFormatter (PKStandardFormats)

+ (NSDateFormatter *)iso8601DateFormatter;
+ (NSDateFormatter *)rfc2616DateFormatterWithFormat:(NSString *)aFormat;

@end

