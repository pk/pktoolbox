//
//  PKGCDTimer.m
//  PKToolBox
//
//  Created by Pavel Kunc on 14/01/2014.
//  Copyright (c) 2014 Fry-it, Limited. All rights reserved.
//

#import "PKGCDTimer.h"

@import Darwin.Mach.mach_time;

@implementation PKGCDTimer {
    dispatch_source_t _source;
    dispatch_queue_t  _queue;

    NSTimeInterval _lastFired;
    NSTimeInterval _lastFinished;
    NSTimeInterval _elapsedDelay;
}

- (instancetype)init {
    return [self initWithTickHandler:nil timeoutHandler:nil];
}

- (instancetype)initWithTickHandler:(PKGCDTimerTickBlock)tickHanlder {
    return [self initWithTickHandler:tickHanlder timeoutHandler:nil];
}

- (instancetype)initWithTimeoutHandler:(PKGCDTimerTimeoutBlock)timeoutHandler {
    return [self initWithTickHandler:nil timeoutHandler:timeoutHandler];
}

- (instancetype)initWithTickHandler:(PKGCDTimerTickBlock)tickHanlder
                     timeoutHandler:(PKGCDTimerTimeoutBlock)timeoutHandler {
    self = [super init];
    if (!self) return nil;

    self->_tickHandler = tickHanlder;
    self->_timeoutHandler = timeoutHandler;
    self->_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    return self;
}


#pragma mark - Public API

- (void)performBlock:(PKGCDTimerTaskBlock)aTask
               every:(NSTimeInterval)aInterval {
    [self performBlock:aTask every:aInterval timeout:0.0 retries:0];
}

- (void)performBlock:(PKGCDTimerTaskBlock)aTask
               every:(NSTimeInterval)aInterval
             timeout:(NSTimeInterval)aTimeout {
    [self performBlock:aTask every:aInterval timeout:aTimeout retries:0];
}

// Perform repeating action with optional timeout for each of the invocations.
- (void)performBlock:(PKGCDTimerTaskBlock)aTaskBlock
              every:(NSTimeInterval)aInterval
             timeout:(NSTimeInterval)aTimeout
             retries:(NSUInteger)aRetries {

    if (self->_source == nil) {
        self->_source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                               0,
                                               0,
                                               self->_queue);
    }

    dispatch_source_set_timer(self->_source,
                              dispatch_time(DISPATCH_TIME_NOW, 0),
                              aInterval * NSEC_PER_SEC,
                              0);

    __block __typeof(self) __weak weakSelf = self;

    __block NSUInteger retries = aRetries + 1;
    dispatch_source_set_event_handler(self->_source, ^{
        __typeof(weakSelf) __strong blockSelf = weakSelf;

        if (aTimeout > 0) {
            NSTimeInterval delta =
                abs(ceilf(blockSelf->_lastFinished) - ceilf(blockSelf->_lastFired));
            if (delta >= aInterval) {
                retries--;
                if (retries != 0) return;

                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!blockSelf.timeoutHandler) return;
                    blockSelf.timeoutHandler();
                });

                [blockSelf invalidate];

                return;
            }

            blockSelf->_lastFired = [blockSelf _now];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            aTaskBlock();
        });
    });

    dispatch_source_set_cancel_handler(self->_source, ^{
        __typeof(weakSelf) __strong blockSelf = weakSelf;
        if (blockSelf == nil) return;

        blockSelf->_lastFired = 0;
        blockSelf->_lastFinished = 0;
        blockSelf->_source = nil;
    });

    dispatch_resume(self->_source);
}

// Watchdog
- (void)performBlock:(PKGCDTimerTaskBlock)aTaskBlock
           withDelay:(NSTimeInterval)delay {

    __block __typeof(self) __weak weakSelf = self;

    if (self->_source == nil) {
        self->_source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                               0,
                                               0,
                                               self->_queue);
    }

    dispatch_source_set_timer(self->_source,
                              dispatch_time(DISPATCH_TIME_NOW, 0),
                              1 * NSEC_PER_SEC,
                              0);

    dispatch_source_set_event_handler(self->_source, ^{
        __typeof(weakSelf) __strong blockSelf = weakSelf;

        blockSelf->_elapsedDelay++;
        NSTimeInterval remainingDelay = delay - blockSelf->_elapsedDelay;
        if (blockSelf.tickHandler != NULL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                blockSelf.tickHandler(blockSelf, delay, remainingDelay);
            });
        }

        if (remainingDelay == 0) {
            if (aTaskBlock != NULL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    aTaskBlock();
                });
            }
            [blockSelf invalidate];
        }
    });

    dispatch_source_set_cancel_handler(self->_source, ^{
        __typeof(weakSelf) __strong blockSelf = weakSelf;
        if (blockSelf == nil) return;

        dispatch_async(dispatch_get_main_queue(), ^{
            blockSelf->_source = nil;
        });
    });

    dispatch_resume(self->_source);
}

- (void)invalidate {
    if (self->_source == nil) return;
    dispatch_source_cancel(self->_source);
}

- (void)markTaskFinished {
    self->_lastFinished = [self _now];
}


#pragma mark - Private

- (NSTimeInterval)_now {
    static mach_timebase_info_data_t info;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        mach_timebase_info(&info);
    });

    NSTimeInterval t = mach_absolute_time();
    t *= info.numer;
    t /= info.denom;
    return t / NSEC_PER_SEC;
}

@end

