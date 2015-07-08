//
//  YLAccount.h
//  WeiBo
//  帐号模型
//  Created by jlt on 15/5/26.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLAccount : NSObject<NSCoding>
@property(nonatomic,copy) NSString *access_token;
@property(nonatomic,assign) long long expires_in;
@property(nonatomic,assign) long long remind_in;
@property(nonatomic,assign) long long uid;
@property(nonatomic,strong) NSDate *expireTime;//帐号的过期时间
+(instancetype)accountWithDict:(NSDictionary *)dict;
@property(nonatomic,copy) NSString *name;
@end
