//
//  PKWebBrowserController.h
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz
//

#import <UIKit/UIKit.h>


@interface PKWebBrowserController : UIViewController <UIWebViewDelegate> {
@private
    NSString        *loadingTitle_;
    UINavigationBar *navigationBar_;
    UIToolbar       *toolBar_;
    UIWebView       *webView_;
}

@property (nonatomic, retain, readwrite) UINavigationBar *navigationBar;
@property (nonatomic, retain, readwrite) UIToolbar       *toolBar;
@property (nonatomic, retain, readwrite) UIWebView       *webView;
@property (nonatomic, copy, readwrite)   NSString        *loadingTitle;

- (void)loadRequest:(NSURLRequest *)aRequest;
- (void)loadURL:(NSURL *)aURL;
- (void)loadURLString:(NSString *)aURL;

- (IBAction)back;
- (IBAction)forward;
- (IBAction)refresh;

@end
