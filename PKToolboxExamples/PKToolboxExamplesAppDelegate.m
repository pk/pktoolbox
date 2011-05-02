//
//  PKToolboxExamplesAppDelegate.m
//  PKToolboxExamples
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright 2011 Fry-it, Limited. All rights reserved.
//

#import "PKToolboxExamplesAppDelegate.h"
#import "PKWebBrowserController.h"

@implementation PKToolboxExamplesAppDelegate

@synthesize window = window_;

- (void)dealloc {
    [window_ release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    PKWebBrowserController *webBrowser = [[PKWebBrowserController alloc] init];
    self.window.rootViewController = webBrowser;
    [webBrowser loadURLString:@"http://www.google.com"];
    [webBrowser release];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application { }

- (void)applicationDidEnterBackground:(UIApplication *)application { }

- (void)applicationWillEnterForeground:(UIApplication *)application { }

- (void)applicationDidBecomeActive:(UIApplication *)application { }

- (void)applicationWillTerminate:(UIApplication *)application { }

@end
