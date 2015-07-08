//
//  YLTabBar.h
//  WeiBo
//
//  Created by lyl on 15/5/18.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLTabBar;
@protocol YLTabBarDelegate<NSObject>
@optional
-(void)yltabBar:(YLTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
@end
@interface YLTabBar : UIView
-(void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property(nonatomic,assign)id<YLTabBarDelegate> tabBarDelegate;
@end
