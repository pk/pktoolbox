//
//  PKAlertView.h
//  PKToolBox
//
//  Created by Pavel Kunc on 16/03/2013.
//  Copyright (c) 2013 Pavel Kunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKAlertView : UIAlertView

+ (PKAlertView *)alertWithSystemError:(NSError *)error delegate:(id)delegate;

@end

