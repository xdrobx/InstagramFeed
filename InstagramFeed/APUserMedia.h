//
//  APUserMedia.h
//  InstagramFeed
//
//  Created by mac on 09.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APUserMedia : NSObject

@property (nonatomic, strong) NSString* mediaId;
@property (nonatomic, strong) NSString* standardUrl;
@property (nonatomic, assign) NSUInteger likes;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* userAvatar;
@property (nonatomic, strong) NSString* isLiked;

+ (void)getUserMediaWithId:(NSString*)userId withAccessToken:(NSString*)accessToken block:(void (^)(NSArray *records))block;

@end
