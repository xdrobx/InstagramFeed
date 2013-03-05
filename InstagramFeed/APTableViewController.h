//
//  APTableViewController.h
//  InstagramFeed
//
//  Created by mac on 02.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APPullToRefresh.h"

@interface APTableViewController : APPullToRefresh
{
    BOOL isLoadingNewPage;//if loading new data when scrolling then YES
}

@property (nonatomic, strong) NSArray* feed;
@property (nonatomic, strong) NSString* accessToken;
@property (nonatomic, strong) NSString* nextURL;

- (id) initWithAccessToken:(NSString*)newAccessToken andFeed:(NSArray*)initFeed andNextURL:(NSString*)nextPageURL;
- (void) requestFeed;

@end
