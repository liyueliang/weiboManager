//
//  YLTool.m
//  WeiBo
//
//  Created by jlt on 15/5/26.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLTool.h"
#import "YLCustomerTabController.h"
#import "YLNewfeatureViewController.h"
@implementation YLTool
+(void)chooseRootController{
    //取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *lastVersion =[defaults stringForKey:@"versionCode"];
    //获取当前软件的版本号
    NSString * currentVersion =[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if ([lastVersion isEqualToString:currentVersion]) {
       [UIApplication sharedApplication].keyWindow.rootViewController =[[YLCustomerTabController alloc]init];
    }else {
        [UIApplication sharedApplication].keyWindow.rootViewController =[[YLNewfeatureViewController alloc]init];
        //存储新版本
        [defaults setObject:currentVersion forKey:@"versionCode"];
        [defaults synchronize];
    }

}
@end
