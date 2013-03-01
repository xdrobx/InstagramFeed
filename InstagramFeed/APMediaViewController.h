//
//  APMediaViewController.h
//  InstagramFeed
//
//  Created by mac on 28.02.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APMediaViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) NSString* accessToken;
@property (nonatomic, strong) NSArray* feed;

-(void)requestFeed;

@end
