//
//  APMediaViewController.h
//  InstagramFeed
//
//  Created by mac on 28.02.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APLogInController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) NSString* accessToken;

-(void)loadTableView;

@end
