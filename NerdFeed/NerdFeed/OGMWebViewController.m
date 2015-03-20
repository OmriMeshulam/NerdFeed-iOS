//
//  OGMWebViewController.m
//  NerdFeed
//
//  Created by Omri Meshulam on 3/19/15.
//  Copyright (c) 2015 Omri Meshulam. All rights reserved.
//

#import "OGMWebViewController.h"

@implementation OGMWebViewController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) loadView
{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
}

- (void)setURL:(NSURL *)URL
{
    _URL = URL;
    if(_URL){
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    // If this bar button item does nto have a title it wil not show at all
    barButtonItem.title = @"Courses";
    
    // Take this bar button item and put it on the left side of the nav item
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Remove the bar button item from the navigation item
    // Double check that it is correct button, even though we know it is
    if (barButtonItem == self.navigationItem.leftBarButtonItem){
        self.navigationItem.leftBarButtonItem = nil;
    }
}

@end
