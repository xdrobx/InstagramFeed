//
//  APCustomTableViewCell.h
//  InstagramFeed
//
//  Created by mac on 02.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APCustomTableViewCell : UITableViewCell
{
    NSString* imageURL;
    NSString* username;
}

@property (nonatomic, strong) NSString* imageURL;
@property (nonatomic, strong) NSString* username;

@end
