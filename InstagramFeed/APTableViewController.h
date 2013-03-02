//
//  APTableViewController.h
//  InstagramFeed
//
//  Created by mac on 02.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APTableViewController : UITableViewController

@property (nonatomic, strong)NSArray* feed;

-(id)initWithFeed:(NSArray*)newFeed;

@end
