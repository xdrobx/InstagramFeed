//
//  APMediaRemoveLike.m
//  InstagramFeed
//
//  Created by mac on 09.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import "APMediaRemoveLike.h"
#import "APInstagram.h"

@implementation APMediaRemoveLike

+ (void)removeLikeForMediaId:(NSString *)mediaId withAccessToken:(NSString *)accessToken block:(void (^)(NSString* code))block
{
    
    NSString* newAccessToken = @"255061919.f59def8.cba8ab7e474d4b8a92c52e96db684621";
    NSString* path = [NSString stringWithFormat:kPostLikeEndpoint, mediaId, newAccessToken];
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:mediaId, @"media_Id", newAccessToken, @"access_token", nil];
    
    [[APInstagram sharedClient] deletePath:path
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     
                                     NSArray* meta = [responseObject objectForKey:@"meta"];
                                     
                                     if (block) {
                                         block([meta valueForKey:@"code"]);
                                     }
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"error: %@", error.localizedDescription);
                                     if (block) {
                                         block([NSString string]);
                                     }
                                 }];
}

@end
