//
//  APInstagramFeed.h
//  InstagramFeed
//
//  Created by mac on 01.03.13.
//  Copyright (c) 2013 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APInstagramFeed : NSObject{
    NSString* standardUrl;
    NSUInteger likes;
    NSString* username;
    NSString* userAvatar;
}

@property (nonatomic, strong) NSString* standardUrl;
@property (nonatomic, assign) NSUInteger likes;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* userAvatar;

+ (void)getFeedMediaWithAccessToken:(NSString*)accessToken andPath:(NSString*)certainPath block:(void (^)(NSArray *records, NSString* nextPage))block;

@end
