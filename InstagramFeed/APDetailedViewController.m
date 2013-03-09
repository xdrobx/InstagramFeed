//
//  APDetailedViewController.m
//  InstagramFeed
//
//  Created by mac on 02.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APDetailedViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APMediaInformation.h"
#import "APMediaPostLike.h"
#import "APMediaRemoveLike.h"

@interface APDetailedViewController ()
{
    NSUInteger likes;
    BOOL isLiked;
}
@end

@implementation APDetailedViewController

@synthesize username;
@synthesize photoURL;
@synthesize avatarURL;
@synthesize mediaId;
@synthesize accessToken = _accessToken;
@synthesize likeButton;

-(id)initWithData:(APUserMedia *)data andAccessToken:(NSString *)accessToken{
    self = [super init];
    if (self) {
        photoURL = [data standardUrl];
        avatarURL = [data userAvatar];
        username = [data username];
        mediaId = [data mediaId];
        self.accessToken = accessToken;

        [self reloadMedia];
    }
    return self;
}

- (void)reloadMedia{
    [APMediaInformation getMediaWithId:mediaId andAccessToken:self.accessToken block:^(APMediaInformation *media) {

        likes = media.likes;
        if([[media isLiked]intValue]==1)isLiked = YES;
        else isLiked = NO;
        
        NSString* butStr = [NSString stringWithFormat:@"%d likes",likes];
        [likeButton setTitle:butStr forState:UIControlStateNormal];
        [likeButton addTarget:self action:@selector(buttonPressed)
             forControlEvents:UIControlEventTouchUpInside];
        [likeButton setAdjustsImageWhenHighlighted:YES];
        
        if(!isLiked) {
            [likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }];
}

- (void)loadView{
    [super loadView];
    
    UIImageView* avatar = [[[UIImageView alloc]initWithFrame:CGRectMake(5,5,45,45)]autorelease];
    avatar.contentMode = UIViewContentModeScaleAspectFit;
    [avatar setImageWithURL:[NSURL URLWithString:avatarURL]placeholderImage:[UIImage imageNamed:@"image-placeholder.png"]];
    
    UILabel* user = [[[UILabel alloc]initWithFrame:CGRectMake(60,20,250,20)]autorelease];
    user.text = username;
    
    UIImageView* photo = [[[UIImageView alloc]initWithFrame:CGRectMake(5,55,310,310)]autorelease];
    photo.contentMode = UIViewContentModeScaleAspectFit;
    [photo setImageWithURL:[NSURL URLWithString:photoURL]placeholderImage:[UIImage imageNamed:@"loading_image_placeholder.png"]];
    
    likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    likeButton.frame = CGRectMake(5,370,310,40);
    [likeButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    [self.view addSubview:likeButton];
    [self.view addSubview:avatar];
    [self.view addSubview:photo];
    [self.view addSubview:user];
}

- (void)buttonPressed
{
    if(!isLiked)
    {
        isLiked = YES;
        likes+=1;
        NSString *newTitle = [NSString stringWithFormat:@"%d likes",likes];
        [likeButton setTitle:newTitle forState:UIControlStateNormal];
        [likeButton setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        [APMediaPostLike postLikeForMediaId:mediaId withAccessToken:self.accessToken block:^(NSString *code) {

        }];
    }
    else
    {
        isLiked = NO;
        likes-=1;
        NSString *newTitle = [NSString stringWithFormat:@"%d likes",likes];
        [likeButton setTitle:newTitle forState:UIControlStateNormal];
        [likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [APMediaRemoveLike removeLikeForMediaId:mediaId withAccessToken:self.accessToken block:^(NSString *code) {
            
        }];
    }
}

@end
