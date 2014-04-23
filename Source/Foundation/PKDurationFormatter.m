//
//  PKDurationFormatter.m
//  PKToolBox
//
//  Created by Pavel Kunc on 28/03/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

#import "PKDurationFormatter.h"

static const double kSecondsPerMinute = 60.0;
static NSString * const kDefaultDurationFormat     = @"%02d:%02.0f.%02.0f";
static NSString * const kDefaultZeroDurationString = @"00:00.00";


@interface PKDurationFormatter ()
@property (nonatomic, copy, readwrite) NSString *format;
@property (nonatomic, copy, readwrite) NSString *zeroDurationString;
@end


@implementation PKDurationFormatter

- (instancetype)init {
    self = [super init];
    if (self == nil) return nil;

    self->_format = kDefaultDurationFormat;
    self->_zeroDurationString = kDefaultZeroDurationString;

    return self;
}

- (NSString *)stringFromNumber:(NSTimeInterval)aNumber {
    if (aNumber == 0.0) return self.zeroDurationString;

    NSUInteger minutes = aNumber / kSecondsPerMinute;
    double seconds = 0.0;
    double miliseconds = modf(aNumber - (minutes * kSecondsPerMinute), &seconds);

    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wformat-nonliteral"
    NSString *duration = [NSString stringWithFormat:self.format,
                                                    minutes,
                                                    seconds,
                                                    (miliseconds * 100)];
    #pragma clang diagnostic pop

    return duration;
}

@end

