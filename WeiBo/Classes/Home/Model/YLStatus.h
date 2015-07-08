//
//  YLStatus.h
//  WeiBo
//
//  Created by jlt on 15/5/27.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLUser.h"
@interface YLStatus : NSObject
//微博的内容
@property(nonatomic,copy) NSString *text;
//微博的来源
@property(nonatomic,copy) NSString *source;
//微博的id
@property(nonatomic,copy) NSString *idstr;
//微博的转发数
@property(nonatomic,assign) int reposts_count;
//微博的评论数
@property(nonatomic,assign) int comments_count;
//赞
@property(nonatomic,assign) int attitudes_count;
@property(nonatomic,strong) YLUser  *user;
@property(nonatomic,strong) NSArray *pic_urls;
//@property(nonatomic,copy) NSString *thumbnail_pic;
@property(nonatomic,copy) NSString *created_at;
//被转发的微博
@property(nonatomic, strong) YLStatus *retweeted_status;

//+(instancetype)statusWithDict:(NSDictionary *)dict;
@end
