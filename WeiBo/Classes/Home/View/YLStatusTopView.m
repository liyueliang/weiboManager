//
//  YLStatusTopView.m
//  WeiBo
//
//  Created by jlt on 15/5/28.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLStatusTopView.h"
#import "UIImageView+WebCache.h"
#import "YLReweetStatusView.h"
#import "YLPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface YLStatusTopView()
@property(nonatomic,weak) UIImageView *iconView;//头像
@property(nonatomic,weak) UIImageView *vipView;//会员图标
@property(nonatomic,weak) UIImageView *photoView;//配图


@property(nonatomic,weak) UILabel *nameLabel;//昵称
@property(nonatomic,weak) UILabel *timeLabel;//时间
@property(nonatomic,weak) UILabel *sourceLabel;//来源
@property(nonatomic,weak) UILabel *contentLabel;//正文


//被转发微博的控件
@property(nonatomic,weak) YLReweetStatusView *retweetView;
@end
@implementation YLStatusTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled=YES;
        self.image=[UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage=[UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        
        //头像
        UIImageView *iconView =[[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView =iconView;
        //会员图标
        UIImageView *vipView =[[UIImageView alloc]init];
        vipView.contentMode=UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView =vipView;
        //配图
        UIImageView *phontoView =[[UIImageView alloc]init];
        [self addSubview:phontoView];
        phontoView.userInteractionEnabled=YES;
        UITapGestureRecognizer *imgTapGap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgShow:)];
        [phontoView addGestureRecognizer:imgTapGap];
        self.photoView =phontoView;
        
        
        UILabel *nameLabel =[[UILabel alloc]init];
        nameLabel.font=YLStatusNameFont;
        nameLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel =nameLabel;
        
        
        
        UILabel *timeLabel =[[UILabel alloc]init];
        timeLabel.font=YLStatusTimeFont;
        timeLabel.backgroundColor=[UIColor clearColor];
        timeLabel.textColor=ylColor(240, 140, 19);
        [self addSubview:timeLabel];
        self.timeLabel =timeLabel;
        
        UILabel *sourceLabel =[[UILabel alloc]init];
        sourceLabel.font=YLStatusSoureFont;
        sourceLabel.textColor =ylColor(135, 135, 135);
        sourceLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel =sourceLabel;
        
        UILabel *contentLabel =[[UILabel alloc]init];
        contentLabel.font =YLStatusContentFont;
        contentLabel.textColor=ylColor(39, 39, 39);
        contentLabel.backgroundColor=[UIColor clearColor];
        contentLabel.numberOfLines=0;
        [self addSubview:contentLabel];
        self.contentLabel =contentLabel;
        
        //添加被转发的view
        
        YLReweetStatusView *reweetView =[[YLReweetStatusView alloc]init];
        [self addSubview:reweetView];
        self.retweetView = reweetView;
    }
    return self;
}
-(void)setStatusFrame:(YLStatusFrame *)statusFrame{
    _statusFrame =statusFrame;
    YLStatus *status =statusFrame.status;
    YLUser *user=status.user;
    //头像
    self.iconView.frame =self.statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    //昵称
    self.nameLabel.frame=self.statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    //时间
    CGFloat timeX =self.nameLabel.frame.origin.x;
    CGFloat timeY =CGRectGetMaxY(self.nameLabel.frame) +YLStatusBorder *0.5;
    
    CGSize timeSize= [status.created_at sizeWithFont:YLStatusTimeFont];
    self.timeLabel.frame =CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    self.timeLabel.text = status.created_at;
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) +YLStatusBorder;
    CGFloat sourceY = timeY;
    CGSize sourceSize =[status.source sizeWithFont:YLStatusSoureFont];
    self.sourceLabel.frame =CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    self.sourceLabel.text =status.source;
    
    
    //
    //    //来源
    
    
    //vip
    if (user.mbtype>2) {
        self.vipView.hidden=NO;
        self.vipView.image=[UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.vipView.frame =self.statusFrame.vipViewF;
        self.nameLabel.textColor=[UIColor orangeColor];
    }else{
        self.vipView.hidden=YES;
        self.nameLabel.textColor=[UIColor blackColor];
    }
    //正文
    self.contentLabel.frame=self.statusFrame.contentLabelF;
    self.contentLabel.text =status.text;
    
    //配图
    if (status.pic_urls.count) {
        self.photoView.frame=self.statusFrame.photoViewF;
        self.photoView.hidden =NO;
        YLPhoto *photoEntity = [status.pic_urls lastObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photoEntity.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    }else{
        self.photoView.hidden=YES;
    }
 
    //设置被转微博数据
    [self setupWeetData];
    
}
-(void)setupWeetData{
    YLStatus *retweeted_status = self.statusFrame.status.retweeted_status;
    if (retweeted_status) {
        self.retweetView.hidden=NO;
        self.retweetView.frame=self.statusFrame.retweetViewF;
        self.retweetView.statusFrame =self.statusFrame;
    }else{
        self.retweetView.hidden=YES;
    }
}
-(void)imgShow:(UITapGestureRecognizer *)obj{
        // 1.封装图片数据
        NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:0];
            // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        mjphoto.srcImageView = (UIImageView *)obj.view; // 来源于哪个UIImageView
        
        YLPhoto *iwphoto = [_statusFrame.status.pic_urls lastObject];
        NSString *photoUrl = [iwphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];

}
@end
