//
//  APDetailedViewController.h
//  InstagramFeed
//
//  Created by mac on 02.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APInstagramFeed.h"

@interface APDetailedViewController : UIViewController

@property (nonatomic, strong) NSString* photoURL;
@property (nonatomic, strong) NSString* avatarURL;
@property (nonatomic, strong) NSString* username;

-(id)initWithData:(APInstagramFeed*)data;

@end
