//
//  NSString+PKNotificationHandlingAdditions.m
//  PKToolBox
//
//  Created by Pavel Kunc on 08/04/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

#import "NSObject+PKNotificationHandlingAdditions.h"

@implementation NSObject (PKNotificationHandlingAdditions)

- (void)pk_registerNotificationObservers {
    SEL selector = @selector(pk_handleNotification:);
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSSet *notifications = [[self class] pk_observedNotifications];
    for (NSString *notification in notifications) {
        [nc addObserver:self selector:selector name:notification object:nil];
    }
}

- (void)pk_removeNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pk_handleNotification:(NSNotification *)aNotification {
    if ([NSThread isMainThread]) {
        [self pk_handleNotificationOnMainThread:aNotification];
    } else {
        __block __typeof(self) __weak weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof(weakSelf) __strong blockSelf = weakSelf;
            [blockSelf pk_handleNotificationOnMainThread:aNotification];
        });
    }
}

@end
