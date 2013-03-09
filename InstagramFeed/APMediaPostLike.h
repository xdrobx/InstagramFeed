//
//  APMediaLike.h
//  InstagramFeed
//
//  Created by mac on 08.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APMediaPostLike : NSObject

+ (void)postLikeForMediaId:(NSString*)mediaId withAccessToken:(NSString*)accessToken block:(void (^)(NSString* code))block;

@end
