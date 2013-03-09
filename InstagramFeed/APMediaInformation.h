//
//  APMediaInformation.h
//  InstagramFeed
//
//  Created by mac on 09.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APMediaInformation : NSObject

@property (nonatomic, assign) NSUInteger likes;
@property (nonatomic, strong) NSString* isLiked;

+ (void)getMediaWithId:(NSString*)mediaId andAccessToken:(NSString*)accessToken block:(void (^)(APMediaInformation *media))block;

@end
