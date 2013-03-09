//
//  APUserMedia.m
//  InstagramFeed
//
//  Created by mac on 09.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APUserMedia.h"
#import "APInstagram.h"

@implementation APUserMedia

@synthesize username = _username;
@synthesize standardUrl = _standardUrl;
@synthesize likes = _likes;
@synthesize userAvatar = _userAvatar;
@synthesize mediaId = _mediaId;
@synthesize isLiked;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.standardUrl = [[[attributes valueForKeyPath:@"images"] valueForKeyPath:@"standard_resolution"] valueForKeyPath:@"url"];
    self.mediaId = [attributes valueForKeyPath:@"id"];
    self.likes = [[[attributes objectForKey:@"likes"] valueForKey:@"count"] integerValue];
    isLiked = [attributes valueForKeyPath:@"user_has_liked"];

    return self;
}

+ (void)getUserMediaWithId:(NSString*)userId withAccessToken:(NSString *)accessToken block:(void (^)(NSArray * records))block
{
    NSDictionary* params = [NSDictionary dictionaryWithObject:accessToken forKey:@"access_token"];
    
    NSString* path = [NSString stringWithFormat:kUserMediaRecentEndpoint, userId];

    [[APInstagram sharedClient] getPath:path
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    NSMutableArray *mutableRecords = [NSMutableArray array];
                                    
                                    NSArray* data = [responseObject objectForKey:@"data"];
                                    for (NSDictionary* obj in data) {
                                        APUserMedia* media = [[APUserMedia alloc] initWithAttributes:obj];
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
