//
//  NSObject+PKNotificationHandlingAdditions.h
//  PKToolBox
//
//  Created by Pavel Kunc on 08/04/2014.
//  Copyright (c) 2014 Pavel Kunc. All rights reserved.
//

@import Foundation;
#import "PKNotificationHandlingProtocol.h"

@interface NSObject (PKNotificationHandlingAdditions) <PKNotificationHandlingProtocol>
- (void)pk_registerNotificationObservers;
- (void)pk_removeNotificationObservers;
- (void)pk_handleNotification:(NSNotification *)notification;
@end
