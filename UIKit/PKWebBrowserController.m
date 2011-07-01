//
//  PKWebBrowserController.m
//  PKToolbox
//
//  Created by Pavel Kunc on 29/04/2011.
//  Copyright (C) 2011 by Pavel Kunc, http://pavelkunc.cz
//

#import "PKWebBrowserController.h"
#import "PKNavigationItem.h"


static int const PKWebBrowserBarHeight = 44;

@interface PKWebBrowserController ()
@property (nonatomic, retain, readwrite) UIBarButtonItem *backBarButton;
@property (nonatomic, retain, readwrite) UIBarButtonItem *forwardBarButton;
@end


@implementation PKWebBrowserController

@synthesize backBarButton    = backBarButton_;
@synthesize forwardBarButton = forwardBarButton_;
@synthesize loadingTitle     = loadingTitle_;
@synthesize navigationBar    = navBar_;
@synthesize presentedModally = presentedModally_;
@synthesize toolBar          = toolBar_;
@synthesize webView          = webView_;

#pragma mark - Initialization/Memory management

- (id)init {
    self = [super init];
    if (self) {
        loadingTitle_ = NSLocalizedString(@"Loading...", nil);
        presentedModally_ = NO;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        loadingTitle_ = NSLocalizedString(@"Loading...", nil);
    }
    return self;
}

- (void)dealloc {
    [backBarButton_    release];
    [forwardBarButton_ release];
    [loadingTitle_     release];
    [navigationBar_    release];
    [toolBar_          release];
    [webView_          release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle

- (void)loadView {
    CGRect screen = [[UIScreen mainScreen] applicationFrame];
    self.view = [[UIView alloc] initWithFrame:screen];
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

    CGRect frame = CGRectMake(0,
                              0,
                              self.view.frame.size.width,
                              PKWebBrowserBarHeight);
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:frame];
    self.navigationBar.autoresizesSubviews = YES;
    self.navigationBar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin);

    frame = CGRectMake(0,
                       self.navigationBar.frame.size.height,
                       self.view.frame.size.width,
                       self.view.frame.size.height - self.navigationBar.frame.size.height);
    self.webView = [[UIWebView alloc] initWithFrame:frame];
    self.webView.delegate = self;
    self.webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

    /*
    frame = CGRectMake(0,
                       self.navigationBar.frame.size.height + self.webView.frame.size.height,
                       self.view.frame.size.width,
                       PKWebBrowserBarHeight);
    self.toolBar = [[UIToolbar alloc] initWithFrame:frame];
    self.toolBar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    [self.view addSubview:self.toolBar];
    */

    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.webView];
}

- (void)viewDidLoad {
    UIBarButtonItem *backButton =
        [[UIBarButtonItem alloc] initWithTitle:@"\u25C0"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(back)];
    backButton.width = 20.0;
    backButton.enabled = NO;
    self.backBarButton = backButton;

    UIBarButtonItem *forwardButton =
        [[UIBarButtonItem alloc] initWithTitle:@"\u25B6"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(forward)];
    forwardButton.width = 20.0;
    forwardButton.enabled = NO;
    self.forwardBarButton = forwardButton;

    UIBarButtonItem *refreshButton =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                      target:self
                                                      action:@selector(refresh)];
    refreshButton.tag = UIBarButtonSystemItemRefresh;

    UIBarButtonItem *spacerButton =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                      target:nil
                                                      action:nil];
    spacerButton.tag = UIBarButtonSystemItemFlexibleSpace;

    PKNavigationItem *item = [[PKNavigationItem alloc] initWithTitle:self.title];
    [item setLeftButtons:spacerButton,
                         backButton,
                         forwardButton,
                         spacerButton,
                         refreshButton,
                         spacerButton, nil];

    if (self.presentedModally) {
        UIBarButtonItem *closeButton =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                          target:self
                                                          action:@selector(close)];
        closeButton.tag = UIBarButtonSystemItemDone;
        [item setRightButtons: closeButton, nil];
        [closeButton release];
    }

    [self.navigationBar setItems:[NSArray arrayWithObject:item] animated:NO];
    [spacerButton release];
    [backButton release];
    [forwardButton release];
    [refreshButton release];
    [item release];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.navigationBar = nil;
    self.toolBar = nil;
    self.webView = nil;
    self.backBarButton = nil;
    self.forwardBarButton = nil;
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

- (IBAction)refresh {
    [self.webView stopLoading];
    [self.webView reload];
}

- (IBAction)close {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - UIWebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    self.navigationBar.topItem.title = self.title = self.loadingTitle;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];

    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
    self.navigationBar.topItem.title = self.title = title;

    self.backBarButton.enabled = [self.webView canGoBack] ? YES : NO;
    self.forwardBarButton.enabled = [self.webView canGoForward] ? YES : NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
    self.navigationBar.topItem.title = self.title = @"";
}

@end

