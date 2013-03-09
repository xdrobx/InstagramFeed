//
//  APCustomTableViewCell.m
//  InstagramFeed
//
//  Created by mac on 02.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APCustomTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation APCustomTableViewCell

@synthesize imageURL;
@synthesize username;

-(void)setImageURL:(NSString *)url{
    imageURL = url;
    [self.imageView setImageWithURL:[NSURL URLWithString:imageURL]placeholderImage:[UIImage imageNamed:@"loading_image_placeholder.png"]];
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(5,5,310,310);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}
@end
