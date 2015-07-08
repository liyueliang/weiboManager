//
//  YLUser.h
//  WeiBo
//
//  Created by jlt on 15/5/27.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLUser : NSObject
//用户微博id
@property(nonatomic,copy) NSString *idstr;
//用户名称
@property(nonatomic,copy) NSString *name;
//用户头像
@property(nonatomic,copy) NSString *profile_image_url;
//会员等级
@property(nonatomic,assign) int  mbrank;
@property(nonatomic,assign) int mbtype;
//+(instancetype)userWithDict:(NSDictionary *)dict;
@end
