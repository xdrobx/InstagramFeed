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
//#import <QuartzCore/QuartzCore.h>

@interface APMediaViewController ()

@end

@implementation APMediaViewController

@synthesize webView = _webView;
@synthesize accessToken = _accessToken;
@synthesize feed = _feed;

-(void)dealloc{
    self.webView.delegate = nil;
    [_webView release];
    [_accessToken release];
    [_feed release];
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
    self.feed = [[[NSArray alloc]init]autorelease];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestFeed{
    [APInstagramFeed getFeedMediaWithAccessToken:self.accessToken block:^(NSArray *records) {
        self.feed = records;
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
            
        NSLog(@"%@",[[self.feed objectAtIndex:0]username]);
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
