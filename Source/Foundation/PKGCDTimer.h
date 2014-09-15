//
//  PKGCDTimer.h
//  PKToolBox
//
//  Created by Pavel Kunc on 14/01/2014.
//  Copyright (c) 2014 Fry-it, Limited. All rights reserved.
//

@import Foundation;

@class PKGCDTimer;

typedef void (^PKGCDTimerTaskBlock)();
typedef void (^PKGCDTimerTickBlock)(PKGCDTimer *timer, NSTimeInterval delay, NSTimeInterval remaining);
typedef void (^PKGCDTimerTimeoutBlock)();

@interface PKGCDTimer : NSObject

@property (nonatomic, copy, readwrite) PKGCDTimerTimeoutBlock timeoutHandler;
@property (nonatomic, copy, readwrite) PKGCDTimerTickBlock    tickHandler;

- (instancetype)initWithTickHandler:(PKGCDTimerTickBlock)tickHanlder;

- (instancetype)initWithTimeoutHandler:(PKGCDTimerTimeoutBlock)timeoutHandler;

- (instancetype)initWithTickHandler:(PKGCDTimerTickBlock)tickHanlder
                     timeoutHandler:(PKGCDTimerTimeoutBlock)timeoutHandler;

- (void)performBlock:(PKGCDTimerTaskBlock)task
           withDelay:(NSTimeInterval)delay;

- (void)performBlock:(PKGCDTimerTaskBlock)task
               every:(NSTimeInterval)interval;

- (void)performBlock:(PKGCDTimerTaskBlock)task
               every:(NSTimeInterval)interval
             timeout:(NSTimeInterval)timeout;

- (void)performBlock:(PKGCDTimerTaskBlock)task
               every:(NSTimeInterval)interval
             timeout:(NSTimeInterval)timeout
             retries:(NSUInteger)retries;

- (void)markTaskFinished;
- (void)invalidate;

@end
