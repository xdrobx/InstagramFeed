//
//  APInstagram.h
//  InstagramFeed
//
//  Created by mac on 28.02.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

extern NSString * const kInstagramBaseURLString;
extern NSString * const kClientId;
extern NSString * const kRedirectUrl;

// Endpoints
extern NSString * const kLocationsEndpoint;
extern NSString * const kLocationsMediaRecentEndpoint;
extern NSString * const kUserMediaRecentEndpoint;
extern NSString * const kAuthenticationEndpoint;
extern NSString * const kPopularsEndpoint;
extern NSString * const kFeedEndpoint;

@interface APInstagram : AFHTTPClient

+ (APInstagram *)sharedClient;
- (id)initWithBaseURL:(NSURL *)url;

@end
