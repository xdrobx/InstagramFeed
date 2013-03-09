//
//  APMediaRemoveLike.h
//  InstagramFeed
//
//  Created by mac on 09.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APMediaRemoveLike : NSObject

+ (void)removeLikeForMediaId:(NSString*)mediaId withAccessToken:(NSString*)accessToken block:(void (^)(NSString* code))block;

@end
