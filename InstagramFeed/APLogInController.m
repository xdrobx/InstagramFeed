//
//  APMediaViewController.m
//  InstagramFeed
//
//  Created by mac on 28.02.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APLogInController.h"
#import "APInstagram.h"
#import "APInstagramFeed.h"
#import "APTableViewController.h"

@interface APLogInController ()

@end

@implementation APLogInController

@synthesize webView = _webView;
@synthesize accessToken = _accessToken;

-(void)dealloc{
    self.webView.delegate = nil;
    [_webView release];
    [_accessToken release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        /*
        NSHTTPCookie *cookie;
        for (cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
            if ([[cookie domain] compare:@"instagram.com"] == NSOrderedSame)
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
        */
    }
    return self;
}

- (void)loadView{
    [super loadView];
    self.webView = [[[UIWebView alloc] initWithFrame:self.view.bounds]autorelease];
    self.webView.delegate = self;
    NSURLRequest* request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:
                                  [NSString stringWithFormat:kAuthenticationEndpoint, kClientId, kRedirectUrl]]];
    
    [self.webView loadRequest:request];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    //self.navigationItem.title = @"Log in";
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTableView{
    
    [APInstagramFeed getFeedMediaWithAccessToken:self.accessToken andPath:@"" block:^(NSArray *records, NSString *nextPage){
            
        APTableViewController* tv = [[APTableViewController alloc]initWithAccessToken:self.accessToken andFeed:records andNextURL:nextPage];
        [[self navigationController] setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:tv animated:YES];
        [tv release];
    }];
}

#pragma mark - Web view delegate

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    
    if ([request.URL.absoluteString rangeOfString:@"#"].location != NSNotFound) {
        NSString* params = [[request.URL.absoluteString componentsSeparatedByString:@"#"] objectAtIndex:1];
        self.accessToken = [params stringByReplacingOccurrencesOfString:@"access_token=" withString:@""];
        //self.webView.hidden = YES;
        
        [self.webView removeFromSuperview];
        self.webView = nil;
        self.webView.delegate = nil;
        [_webView release];
        [self loadTableView];
    }
    
	return YES;
}

@end
