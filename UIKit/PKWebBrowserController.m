//
//  PKWebBrowserController.m
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "PKWebBrowserController.h"
#import "PKNavigationItem.h"


@implementation PKWebBrowserController

@synthesize navBar  = navBar_;
@synthesize toolBar = toolBar_;
@synthesize webView = webView_;


#pragma mark - Initialization/Memory management

- (id)init {
    return [self initWithNibName:@"PKWebBrowser" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Loading...";
    }
    return self;
}

- (void)dealloc {
    [navBar_ release];
    [toolBar_ release];
    [webView_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    UIBarButtonItem *backButton =
        [[UIBarButtonItem alloc] initWithTitle:@"\u25C0"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(back)];

    UIBarButtonItem *forwardButton =
        [[UIBarButtonItem alloc] initWithTitle:@"\u25B6"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(forward)];


    UIImage *reloadIcon = [UIImage imageNamed:@"refresh.png"];
    UIBarButtonItem *reloadButton =
        [[UIBarButtonItem alloc] initWithImage:reloadIcon
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(reload)];

    UIBarButtonItem *closeButton =
        [[UIBarButtonItem alloc] initWithTitle:@"\u2716"
                                         style:UIBarButtonItemStylePlain
                                        target:nil
                                        action:nil];

    PKNavigationItem *item = [[PKNavigationItem alloc] initWithTitle:self.title];

    [item setLeftButtons:backButton,
                         forwardButton,
                         reloadButton,
                         nil];

    [item setRightButtons:closeButton, nil];

    [self.navBar setItems:[NSArray arrayWithObject:item] animated:NO];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.navBar = nil;
    self.toolBar = nil;
    self.webView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark - Loading content

- (void)loadURLString:(NSString *)aURL {
    NSURL *url = [[NSURL alloc] initWithString:aURL];
    [self loadURL:url];
    [url release];
}

- (void)loadURL:(NSURL *)aURL {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:aURL];
    [self loadRequest:request];
    [request release];
}

- (void)loadRequest:(NSURLRequest *)aRequest {
    [self.webView stopLoading];
    [self.webView loadRequest:aRequest];
}


#pragma mark - UI interaction

- (IBAction)reload {
    [self.webView stopLoading];
    [self.webView reload];
}

- (IBAction)back {
    if ([self.webView canGoBack]) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
}

- (IBAction)forward {
    if ([self.webView canGoForward]) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
}


#pragma mark - UIWebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];

    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
    self.navBar.topItem.title = self.title = title;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
}

@end

