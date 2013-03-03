//
//  APDetailedViewController.m
//  InstagramFeed
//
//  Created by mac on 02.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APDetailedViewController.h"
#import "UIImageView+AFNetworking.h"

@interface APDetailedViewController ()
{
    NSUInteger likes;
}
@end

@implementation APDetailedViewController

@synthesize username;
@synthesize photoURL;
@synthesize avatarURL;
//@synthesize likes;

-(id)initWithData:(APInstagramFeed *)data{
    self = [super init];
    if (self) {
        // Custom initialization
        photoURL = [data standardUrl];
        avatarURL = [data userAvatar];
        username = [data username];
        likes = [data likes];
    }
    return self;
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
    [photo setImageWithURL:[NSURL URLWithString:photoURL]placeholderImage:[UIImage imageNamed:@"image-placeholder.png"]];
    
    UIButton* setlike = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    setlike.frame = CGRectMake(5,370,310,40);
    
    //set the button's title
    NSString* butStr = [NSString stringWithFormat:@"%d likes",likes];
    [setlike setTitle:butStr forState:UIControlStateNormal];
    
    
    [self.view addSubview:avatar];
    [self.view addSubview:photo];
    [self.view addSubview:user];
    [self.view addSubview:setlike];
    NSLog(@"%@",self.avatarURL);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*avatar = [[[UIImageView alloc]initWithFrame:CGRectMake(5,5,100,100)]autorelease];
    //self.avatar.frame = CGRectMake(5,5,40,40);
    self.avatar.contentMode = UIViewContentModeScaleAspectFit;
    [self.avatar setImageWithURL:[NSURL URLWithString:avatarURL]placeholderImage:[UIImage imageNamed:@"image-placeholder.png"]];
    NSLog(@"%@",self.avatarURL);*/
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIView
/*
- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatar.frame = CGRectMake(5,5,40,40);
    self.avatar.contentMode = UIViewContentModeScaleAspectFit;
    //self.imageView.frame = CGRectMake(5,5,310,310);
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    float limgW =  self.imageView.image.size.width;
     if(limgW > 0) {
     CGRect textLabelFrame = CGRectMake(55,0, 265, 25.0f);
     textLabelFrame.size.height = [[self class] heightForCellWithURL:_url];
     self.textLabel.frame = textLabelFrame;
     }
}*/

@end
