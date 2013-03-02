//
//  APMediaViewController.m
//  InstagramFeed
//
//  Created by mac on 28.02.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APMediaViewController.h"
#import "APInstagram.h"
#import "APInstagramFeed.h"
#import "APTableViewController.h"
//#import <QuartzCore/QuartzCore.h>

@interface APMediaViewController ()

@end

@implementation APMediaViewController

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
        
        NSHTTPCookie *cookie;
        for (cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
            if ([[cookie domain] compare:@"instagram.com"] == NSOrderedSame)
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"opa");
    self.webView = [[[UIWebView alloc] initWithFrame:self.view.bounds]autorelease];
    self.webView.delegate = self;
    NSURLRequest* request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:
                                  [NSString stringWithFormat:kAuthenticationEndpoint, kClientId, kRedirectUrl]]];

    [self.webView loadRequest:request];
    
    //[self.view addSubview: self.gridScrollView];
    [self.view addSubview:self.webView];
    //self.feed = [[[NSArray alloc]init]autorelease];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestFeed{
    [APInstagramFeed getFeedMediaWithAccessToken:self.accessToken block:^(NSArray *records) {
        //self.feed = records;
        //self.feed = [[[NSArray alloc]initWithArray:records]autorelease];
        /*int item = 0, row = 0, col = 0;
        for (NSDictionary* image in records) {
            
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:
                                      CGRectMake(0,
                                                 row*1.2*kthumbnailHeight+20,
                                                 kthumbnailWidth,
                                                 kthumbnailHeight)
                                      ];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            col++;item++;
            if (col >= kImagesPerRow) {
                row++;
                col = 0;
            }
            [self.gridScrollView addSubview:imageView];
            [self.thumbnails addObject:imageView];*/
            
        NSLog(@"1- %d",[records count]);
        APTableViewController* tv = [[[APTableViewController alloc]initWithFeed:records]autorelease];
        [self.navigationController pushViewController:tv animated:NO];
        //[tv release];
    }];
    /*
    NSLog(@"1- %d",[self.feed count]);
    APTableViewController* tv = [[APTableViewController alloc]initWithFeed:self.feed];
    [self.navigationController pushViewController:tv animated:YES];
    [tv release];*/
    
}

#pragma mark - Web view delegate

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    
    if ([request.URL.absoluteString rangeOfString:@"#"].location != NSNotFound) {
        NSString* params = [[request.URL.absoluteString componentsSeparatedByString:@"#"] objectAtIndex:1];
        self.accessToken = [params stringByReplacingOccurrencesOfString:@"access_token=" withString:@""];
        self.webView.hidden = YES;
        
        //[self.webView removeFromSuperview];
        //self.webView = nil;
        self.webView.delegate = nil;
        //[_webView release];
        [self requestFeed];
        //NSLog(@"logged %d",[self.webView retainCount]);
    }
    
	return YES;
}

@end
