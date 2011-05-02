//
//  PKToolboxExamplesAppDelegate.h
//  PKToolboxExamples
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright 2011 Fry-it, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKToolboxExamplesAppDelegate : NSObject <UIApplicationDelegate> {
@private
    UIWindow *window_;
}

@property (nonatomic, retain, readwrite) IBOutlet UIWindow *window;

@end
