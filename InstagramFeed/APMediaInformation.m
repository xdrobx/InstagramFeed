//
//  APMediaInformation.m
//  InstagramFeed
//
//  Created by mac on 09.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APMediaInformation.h"
#import "APInstagram.h"

@implementation APMediaInformation

@synthesize likes = _likes;
@synthesize isLiked;


- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.likes = [[[attributes objectForKey:@"likes"] valueForKey:@"count"] integerValue];
    isLiked = [attributes valueForKeyPath:@"user_has_liked"];
    return self;
}

+ (void)getMediaWithId:(NSString*)mediaId andAccessToken:(NSString*)accessToken block:(void (^)(APMediaInformation *media))block{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:accessToken, @"access_token", nil];
    
    NSString* path = [NSString stringWithFormat:kMediaEndpoint,mediaId,accessToken];
    
    [[APInstagram sharedClient] getPath:path
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    
                                    NSDictionary* data = [responseObject objectForKey:@"data"];
                                    
                                    APMediaInformation* media = [[APMediaInformation alloc] initWithAttributes:data];
                                    
                                    if (block) {
                                        block(media);
                                    }
                                    [media release];
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    NSLog(@"error: %@", error.localizedDescription);
                                    if (block) {
                                        block([NSArray array]);
                                    }
                                }];
}

@end
