//
//  YLAccountTool.h
//  WeiBo
//
//  Created by jlt on 15/5/26.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLAccount.h"

@interface YLAccountTool : NSObject
+(void)saveAccount:(YLAccount *)account;
+(YLAccount *)account;
@end
