//
//  OGMWebViewController.m
//  NerdFeed
//
//  Created by Omri Meshulam on 3/19/15.
//  Copyright (c) 2015 Omri Meshulam. All rights reserved.
//

#import "OGMWebViewController.h"

@interface OGMWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIBarButtonItem *backButton;
@property (nonatomic, strong) UIBarButtonItem *forwardButton;

@end

@implementation OGMWebViewController

-(void)loadView {
    self.webView = [[UIWebView alloc] init];
    self.webView.scalesPageToFit = YES;
    UINavigationItem *navItem = self.navigationItem;
    self.backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                              target:self
                                                              action:@selector(goBack:)];
    self.forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                                 target:self
                                                                 action:@selector(goForward:)];
    navItem.rightBarButtonItems = @[self.forwardButton, self.backButton];
    self.view = self.webView;
    [self.backButton setEnabled:NO]; //these two set to NO so you can't click buttons when the first page loads
    [self.forwardButton setEnabled:NO];
    self.webView.delegate = self;
}

- (void)setURL:(NSURL *)URL
{
    _URL = URL;
    if(_URL){
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}

-(void)goBack: (id) sender {
    [self.webView goBack];
}

-(void)goForward: (id) sender {
    [self.webView goForward];
}



-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finished loading");
    [self.backButton setEnabled:[self.webView canGoBack]];
    [self.forwardButton setEnabled:[self.webView canGoForward]];
}


@end
