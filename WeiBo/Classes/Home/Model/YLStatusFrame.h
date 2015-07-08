//
//  YLStatusFrame.h
//  WeiBo
//
//  Created by jlt on 15/5/27.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLStatus.h"

#define YLStatusNameFont [UIFont systemFontOfSize:15]
#define YLStatusTimeFont [UIFont systemFontOfSize:12]
#define YLStatusSoureFont YLStatusTimeFont
#define YLStatusContentFont [UIFont systemFontOfSize:13]
#define YLStatusTableCellBoder 5

#define YLStatusBorder 10

@interface YLStatusFrame : NSObject
@property(nonatomic,strong) YLStatus *status;


@property(nonatomic,assign,readonly) CGRect topViewF;//顶部view
@property(nonatomic,assign,readonly) CGRect iconViewF;//头像
@property(nonatomic,assign,readonly) CGRect vipViewF;//会员图标
@property(nonatomic,assign,readonly) CGRect photoViewF;//配图


@property(nonatomic,assign,readonly) CGRect nameLabelF;//昵称
@property(nonatomic,assign,readonly) CGRect timeLabelF;//时间
@property(nonatomic,assign,readonly) CGRect sourceLabelF;//来源
@property(nonatomic,assign,readonly) CGRect contentLabelF;//正文


//被转发微博的控件
@property(nonatomic,assign,readonly) CGRect retweetViewF;
@property(nonatomic,assign,readonly) CGRect retweetNameLabelF;//昵称
@property(nonatomic,assign,readonly) CGRect retweetContentLabelF;//正文
@property(nonatomic,assign,readonly) CGRect retweetPhontoViewF;//配图

//微博工具条
@property(nonatomic,assign,readonly) CGRect statusToolBarF;
//cell的高度
@property(nonatomic,assign) CGFloat cellHeight;
@end
