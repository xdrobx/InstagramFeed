//
//  APInstagramFeed.m
//  InstagramFeed
//
//  Created by mac on 01.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APInstagramFeed.h"
#import "APInstagram.h"

@implementation APInstagramFeed

@synthesize username = _username;
@synthesize standardUrl = _standardUrl;
@synthesize likes = _likes;
@synthesize userAvatar = _userAvatar;

-(void)dealloc{
    [super dealloc];
}

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.standardUrl = [[[attributes valueForKeyPath:@"images"] valueForKeyPath:@"standard_resolution"] valueForKeyPath:@"url"];
    self.likes = [[[attributes objectForKey:@"likes"] valueForKey:@"count"] integerValue];
    self.username = [[attributes valueForKeyPath:@"user"] valueForKey:@"username"];
    self.userAvatar = [[attributes valueForKeyPath:@"user"] valueForKey:@"profile_picture"];
    
    return self;
}

+ (void)getFeedMediaWithAccessToken:(NSString *)accessToken block:(void (^)(NSArray *records))block
{
    NSDictionary* params = [NSDictionary dictionaryWithObject:accessToken forKey:@"access_token"];
    NSString* path = [NSString stringWithFormat:kFeedEndpoint, @"self"];
    
    [[APInstagram sharedClient] getPath:path
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    NSMutableArray *mutableRecords = [NSMutableArray array];
                                    NSArray* data = [responseObject objectForKey:@"data"];
                                    for (NSDictionary* obj in data) {
                                        APInstagramFeed* media = [[APInstagramFeed alloc] initWithAttributes:obj];
                                        [mutableRecords addObject:media];
                                        [media release];
                                    }
                                    if (block) {
                                        block([NSArray arrayWithArray:mutableRecords]);
                                    }
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    NSLog(@"error: %@", error.localizedDescription);
                                    if (block) {
                                        block([NSArray array]);
                                    }
                                }];
}

@end
