//
//  YLReweetStatusView.m
//  WeiBo
//
//  Created by jlt on 15/5/28.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLReweetStatusView.h"
#import "UIImageView+WebCache.h"
#import "YLPhoto.h"
#import "YLPhotosView.h"
@interface YLReweetStatusView()
@property(nonatomic,weak) UILabel *retweetNameLabel;//昵称
@property(nonatomic,weak) UILabel *retweetContentLabel;//正文
@property(nonatomic,weak) YLPhotosView *retweetPhontoView;//配图
@end
@implementation YLReweetStatusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled=YES;
        self.image=[UIImage resizedImageWithName:@"timeline_retweet_background" left:0.8 top:0.5];
        
        //添加子控件
        UILabel *retweetNameLabel =[[UILabel alloc]init];
        [self addSubview:retweetNameLabel];
        retweetNameLabel.backgroundColor=[UIColor clearColor];
        retweetNameLabel.textColor=ylColor(67, 107, 163);
        self.retweetNameLabel =retweetNameLabel;
        
        UILabel *retweetContentLabel =[[UILabel alloc]init];
        retweetContentLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:retweetContentLabel];
        retweetContentLabel.textColor=ylColor(90, 90, 90);
        self.retweetContentLabel =retweetContentLabel;
        //配图
        YLPhotosView *retweetPhontoView =[[YLPhotosView alloc]init];
        [self addSubview:retweetPhontoView];
        
        self.retweetPhontoView = retweetPhontoView;
        
        
    }
    return self;
}
-(void)setStatusFrame:(YLStatusFrame *)statusFrame{
    _statusFrame =statusFrame;
    
    YLStatus *status = statusFrame.status.retweeted_status;
    YLUser *user = status.user;
    
    //昵称
    self.retweetNameLabel.frame =statusFrame.retweetNameLabelF;
    self.retweetNameLabel.font =YLStatusNameFont;
    self.retweetNameLabel.text =[NSString stringWithFormat:@"@%@",user.name];
    
    //正文
    self.retweetContentLabel.frame=self.statusFrame.retweetContentLabelF;
    self.retweetContentLabel.numberOfLines=0;
    self.retweetContentLabel.font=YLStatusTimeFont;
    self.retweetContentLabel.text =status.text;
    
    
    //配图
    if (status.pic_urls.count) {
        self.retweetPhontoView.hidden =NO;
        self.retweetPhontoView.frame=self.statusFrame.retweetPhontoViewF;
        [self.retweetPhontoView setPhotos:status.pic_urls];
    }else{
        self.retweetPhontoView.hidden=YES;
    }

}
@end
