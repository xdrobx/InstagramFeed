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
@synthesize userAvatar = _userAvatar;
@synthesize mediaId = _mediaId;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.standardUrl = [[[attributes valueForKeyPath:@"images"] valueForKeyPath:@"low_resolution"] valueForKeyPath:@"url"];
    self.username = [[attributes valueForKeyPath:@"user"] valueForKey:@"username"];
    self.userAvatar = [[attributes valueForKeyPath:@"user"] valueForKey:@"profile_picture"];
    self.mediaId = [attributes valueForKeyPath:@"id"];
    return self;
}

+ (void)getFeedMediaWithAccessToken:(NSString *)accessToken andPath:(NSString *)certainPath block:(void (^)(NSArray *records, NSString* nextPage))block
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:accessToken, @"access_token", nil];
    
    NSString* path = nil;
    if([certainPath isEqualToString:@""])
        path = [NSString stringWithFormat:kFeedEndpoint, @"self"];
    else
        path = [NSString stringWithString:certainPath];
    
    [[APInstagram sharedClient] getPath:path
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    NSMutableArray *mutableRecords = [NSMutableArray array];
                                    
                                    NSArray* pagination = [responseObject objectForKey:@"pagination"];
                                    NSString* nextURL = [pagination valueForKeyPath:@"next_url"];
                                    
                                    NSArray* data = [responseObject objectForKey:@"data"];
                                    for (NSDictionary* obj in data) {
                                        APInstagramFeed* media = [[APInstagramFeed alloc] initWithAttributes:obj];
                                        [mutableRecords addObject:media];
                                        [media release];
                                    }
                                    if (block) {
                                        block([NSArray arrayWithArray:mutableRecords],[NSString stringWithString:nextURL]);
                                    }
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    NSLog(@"error: %@", error.localizedDescription);
                                    if (block) {
                                        block([NSArray array],@"");
                                    }
                                }];
}

-(void)dealloc{
    [_username release];
    [_standardUrl release];
    [_userAvatar release];
    [_mediaId release];
    
    [super dealloc];
}

@end
