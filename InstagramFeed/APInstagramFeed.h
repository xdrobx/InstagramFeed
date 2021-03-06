//
//  APInstagramFeed.h
//  InstagramFeed
//
//  Created by mac on 01.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APInstagramFeed : NSObject

@property (nonatomic, strong) NSString* mediaId;
@property (nonatomic, strong) NSString* standardUrl;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* userAvatar;

+ (void)getFeedMediaWithAccessToken:(NSString*)accessToken andPath:(NSString*)certainPath block:(void (^)(NSArray *records, NSString* nextPage))block;

@end
