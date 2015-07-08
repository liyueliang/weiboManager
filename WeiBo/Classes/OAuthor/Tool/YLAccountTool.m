//
//  YLAccountTool.m
//  WeiBo
//
//  Created by jlt on 15/5/26.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLAccountTool.h"
#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation YLAccountTool
+(void)saveAccount:(YLAccount *)account{
    NSDate *now =[NSDate date];
    account.expireTime = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:AccountFile];
}
+(YLAccount *)account{
    YLAccount *tempAccount =[NSKeyedUnarchiver unarchiveObjectWithFile:AccountFile];
    
    NSDate *now =[NSDate date];
    if ([now compare:tempAccount.expireTime]==NSOrderedAscending) {
        return  tempAccount;
    }else{
        return nil;
    }
}
@end
