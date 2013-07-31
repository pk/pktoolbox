//
//  PKAlertView.m
//  PKToolBox
//
//  Created by Pavel Kunc on 16/03/2013.
//  Copyright (c) 2013 Pavel Kunc. All rights reserved.
//

#import "PKAlertView.h"

@implementation PKAlertView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (PKAlertView *)alertWithSystemError:(NSError *)aError delegate:(id)aDelegate {
    NSString *title = NSLocalizedString(@"alert-system-error-title",nil);
    NSString *messageFormat = NSLocalizedString(@"alert-system-error-message-format", nil);
    NSString *message = [NSString stringWithFormat:messageFormat,
                                                   [aError localizedDescription]];
    PKAlertView *alert = [[PKAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:aDelegate
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert setTag:PKAlertViewTagSystemError];
    return alert;
}


#pragma mark - Presentation

- (void)show {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(applicationDidEnterBackground:)
               name:UIApplicationDidEnterBackgroundNotification
             object:nil];

    [super show];
}


#pragma mark - Notification handling

- (void)applicationDidEnterBackground:(NSNotification*) notification {
    [self dismissWithClickedButtonIndex:[self cancelButtonIndex] animated:NO];
}

@end

