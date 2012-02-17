//
//  PKWebBrowserController.h
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz
//

#import <UIKit/UIKit.h>

@class PKWebBrowserController;

@protocol PKWebBrowserControllerDelegate <NSObject>
- (void)needDismissWebBrowser:(PKWebBrowserController *)aWebBrowser;
@end


@interface PKWebBrowserController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain, readwrite) UINavigationBar *navigationBar;
@property (nonatomic, retain, readwrite) UIToolbar       *toolBar;
@property (nonatomic, retain, readwrite) UIWebView       *webView;
@property (nonatomic, copy, readwrite)   NSString        *loadingTitle;
@property (nonatomic, assign, readwrite) id<PKWebBrowserControllerDelegate> delegate;

@property (nonatomic, assign, readwrite, getter=isPresentedModally)    BOOL presentedModally;
@property (nonatomic, assign, readwrite, getter=isBackButtonHidden)    BOOL backButtonHidden;
@property (nonatomic, assign, readwrite, getter=isForwardButtonHidden) BOOL forwardButtonHidden;
@property (nonatomic, assign, readwrite, getter=isRefreshButtonHidden) BOOL refreshButtonHidden;

- (void)loadRequest:(NSURLRequest *)aRequest;
- (void)loadURL:(NSURL *)aURL;
- (void)loadURLString:(NSString *)aURL;

- (IBAction)back;
- (IBAction)forward;
- (IBAction)refresh;
- (IBAction)close;

@end
