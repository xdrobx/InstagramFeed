//
//  APInstagram.m
//  InstagramFeed
//
//  Created by mac on 28.02.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APInstagram.h"
#import "AFJSONRequestOperation.h"

NSString * const kInstagramBaseURLString = @"https://api.instagram.com/v1/";
//client id
NSString * const kClientId = @"dfd1df8de0454488a0200289fb20f1d6";
//redirect uri
NSString * const kRedirectUrl = @"http://artflash.hut2.ru/";

// Endpoints
NSString * const kLocationsEndpoint = @"locations/search";
NSString * const kLocationsMediaRecentEndpoint = @"locations/%@/media/recent";
NSString * const kUserMediaRecentEndpoint = @"users/%@/media/recent";
NSString * const kAuthenticationEndpoint = @"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token";
NSString * const kPopularsEndpoint = @"https://api.instagram.com/v1/media/popular?client_id=%@&access_token=%@";
NSString * const kFeedEndpoint = @"https://api.instagram.com/v1/users/self/feed?access_token=%@";
NSString * const kMediaEndpoint = @"https://api.instagram.com/v1/media/%@?access_token=%@";
NSString * const kPostLikeEndpoint = @"https://api.instagram.com/v1/media/%@/likes?access_token=%@";

@implementation APInstagram

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

+ (APInstagram *)sharedClient
{
    static APInstagram * _sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kInstagramBaseURLString]];
    });
    
    return _sharedClient;
}


@end
