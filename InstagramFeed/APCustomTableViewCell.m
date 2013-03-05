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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImageURL:(NSString *)url{
    imageURL = url;
    //self.textLabel.text = imageURL;
    [self.imageView setImageWithURL:[NSURL URLWithString:imageURL]placeholderImage:[UIImage imageNamed:@"loading_image_placeholder.png"]];
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5,5,310,310);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    /*float limgW =  self.imageView.image.size.width;
    if(limgW > 0) {
        CGRect textLabelFrame = CGRectMake(55,0, 265, 25.0f);
        textLabelFrame.size.height = [[self class] heightForCellWithURL:_url];
        self.textLabel.frame = textLabelFrame;
    }*/
}
@end
