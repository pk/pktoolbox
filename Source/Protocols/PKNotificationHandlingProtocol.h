//
//  PKNotificationHandlingProtocol.h
//  PKToolbox
//
//  Created by Pavel Kunc on 29/11/2012.
//  Copyright (c) 2012 Pavel Kunc. All rights reserved.
//

@import Foundation;

@protocol PKNotificationHandlingProtocol <NSObject>

+ (NSSet *)pk_observedNotifications;
- (void)pk_handleNotificationOnMainThread:(NSNotification *)notification;

@end

