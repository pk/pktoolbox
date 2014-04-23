//
//  PKAlertView.h
//  PKToolBox
//
//  Created by Pavel Kunc on 16/03/2013.
//  Copyright (c) 2013 Pavel Kunc. All rights reserved.
//

@import UIKit;

#ifndef PK_ALERTVIEW_SYSTEM_ERROR_TAG
#define PK_ALERTVIEW_SYSTEM_ERROR_TAG -1000
#endif

@interface PKAlertView : UIAlertView

+ (instancetype)alertWithSystemError:(NSError *)error delegate:(id)delegate;

@end

