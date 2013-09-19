//
//  PKNotificationHandlingProtocol.h
//  PKToolbox
//
//  Created by Pavel Kunc on 29/11/2012.
//  Copyright (c) 2012 Pavel Kunc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PKNotificationHandlingProtocol <NSObject>

- (void)_registerNotificationObservers;
- (void)_removeNotificationObservers;
- (void)_handleNotification:(NSNotification *)notification;
- (void)_handleNotificationOnMainThread:(NSNotification *)notification;

@end

