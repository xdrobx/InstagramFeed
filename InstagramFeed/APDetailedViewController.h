//
//  APDetailedViewController.h
//  InstagramFeed
//
//  Created by mac on 02.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APInstagramFeed.h"
#import "APUserMedia.h"

@interface APDetailedViewController : UIViewController

@property (nonatomic, strong) NSString* photoURL;
@property (nonatomic, strong) NSString* avatarURL;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* mediaId;
@property (nonatomic, strong) NSString* accessToken;
@property (nonatomic, strong) UIButton* likeButton;

- (id)initWithData:(APUserMedia*)data andAccessToken:(NSString*)accessToken;
- (void)buttonPressed;
- (void)reloadMedia;
@end
