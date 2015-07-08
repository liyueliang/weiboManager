//
//  YLStatusFrame.m
//  WeiBo
//
//  Created by jlt on 15/5/27.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLStatusFrame.h"
#import "YLPhotosView.h"


@implementation YLStatusFrame
/*
    获得微博模型数据后,根据微博数据计算所有的子控件的frame
 */
-(void)setStatus:(YLStatus *)status{
    _status =status;
    
    //cell的高度
    CGFloat cellW =[UIScreen mainScreen].bounds.size.width-2*YLStatusTableCellBoder;
    
    //topview
    CGFloat topViewW =cellW;
    CGFloat topViewX =0;
    CGFloat topViewY=0;
    CGFloat topViewH = 0;
    //头像
    CGFloat iconViewWH =35;
    CGFloat iconViewX =YLStatusBorder;
    CGFloat iconViewY=YLStatusBorder;
    _iconViewF =CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF)+YLStatusBorder;
    CGFloat nameLabelY =iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:YLStatusNameFont];
    _nameLabelF =CGRectMake(nameLabelX, nameLabelY, nameLabelSize.width, nameLabelSize.height);
    
    //等级
    if (status.user.mbtype>2) {
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) +YLStatusBorder;
        CGFloat vipViewW=14;
        CGFloat vipViewH =nameLabelSize.height;
        CGFloat vipViewY = nameLabelY;
        _vipViewF =CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    //时间
    CGFloat timeX =nameLabelX;
    CGFloat timeY =CGRectGetMaxY(_nameLabelF) +YLStatusBorder *0.5;
    
    CGSize timeSize= [status.created_at sizeWithFont:YLStatusTimeFont];
    _timeLabelF =CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(_timeLabelF) +YLStatusBorder;
    CGFloat sourceY = timeY;
    CGSize sourceSize =[status.source sizeWithFont:YLStatusSoureFont];
    _sourceLabelF =CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    //正文
    
    CGFloat contextX =iconViewX;
    CGFloat contextY =MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF))+YLStatusBorder*0.5;
    CGFloat contextLabelMaxW = topViewW -2*YLStatusBorder;
    CGSize contextSize = [status.text sizeWithFont:YLStatusContentFont constrainedToSize:CGSizeMake(contextLabelMaxW, MAXFLOAT)];
    _contentLabelF =CGRectMake(contextX, contextY, contextSize.width, contextSize.height);
    
    //配图
    if (status.pic_urls.count) {
        CGFloat phontoX = contextX;
        CGFloat phontoY = CGRectGetMaxY(_contentLabelF) +YLStatusBorder;
        CGFloat phontoWH =70;
        _photoViewF = CGRectMake(phontoX, phontoY, phontoWH, phontoWH);
    }
    
    
    //被转发的微博
    if (status.retweeted_status) {
        //_retweetViewF;
        CGFloat retweentViewX = contextX;
        CGFloat retweentViewY =CGRectGetMaxY(_contentLabelF) +YLStatusBorder*0.5;
        CGFloat retweentViewW = contextLabelMaxW;
        CGFloat retweentViewH = 0;
        //昵称
        CGFloat retweetNameLabelX = YLStatusBorder;
        CGFloat retweetNameLabelY = YLStatusBorder;
        CGSize retweetNameLabelSize=[[NSString stringWithFormat:@"@%@",status.retweeted_status.user.name] sizeWithFont:YLStatusNameFont];
        _retweetNameLabelF =CGRectMake(retweetNameLabelX, retweetNameLabelY, retweetNameLabelSize.width, retweetNameLabelSize.height);
        
        //正文
        CGFloat retweetContentX =  retweentViewX;
        CGFloat retweetContentY = CGRectGetMaxY(_retweetNameLabelF) +YLStatusBorder*0.5;
        CGFloat retweetContentLabelW = retweentViewW -2*YLStatusBorder;
        CGSize retweetContentSize=[status.retweeted_status.text sizeWithFont:YLStatusTimeFont constrainedToSize:CGSizeMake(retweetContentLabelW, MAXFLOAT)];
        
        _retweetContentLabelF =CGRectMake(retweetContentX, retweetContentY, retweetContentSize.width, retweetContentSize.height);
       
        if (status.retweeted_status.pic_urls.count) {
            //图像
            CGFloat retweetPhontoX = retweetContentX;
            CGFloat retweetPhontoY = CGRectGetMaxY(_retweetContentLabelF)+YLStatusBorder ;
            CGSize retweetPhontoSize =[YLPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            _retweetPhontoViewF =CGRectMake(retweetPhontoX, retweetPhontoY,retweetPhontoSize.width, retweetPhontoSize.height);
            retweentViewH = CGRectGetMaxY(_retweetPhontoViewF) +YLStatusBorder;
        }else{
            retweentViewH = CGRectGetMaxY(_retweetContentLabelF )+YLStatusBorder;
        }
        
        //计算被转发微博背景大小
        _retweetViewF =CGRectMake(retweentViewX, retweentViewY, retweentViewW, retweentViewH);
       
        
        //有被转发的微博
        topViewH = CGRectGetMaxY(_retweetViewF)+YLStatusBorder;
    }else{
        //原创微博
        if (status.pic_urls.count) {
            topViewH =CGRectGetMaxY(_photoViewF)+YLStatusBorder;
        }else{
            topViewH =CGRectGetMaxY(_contentLabelF)+YLStatusBorder;
        }
    }
   
    
    
    //topview
   
    _topViewF=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    
    //加载工具条
    CGFloat toolBarViewX = topViewX;
    CGFloat toolBarViewY = CGRectGetMaxY(_topViewF);
    CGFloat toolBarViewW =topViewW;
    CGFloat toolBarViewH=35;
    _statusToolBarF =CGRectMake(toolBarViewX, toolBarViewY, toolBarViewW, toolBarViewH);
    
    
    //cell 高度
    _cellHeight = CGRectGetMaxY(_statusToolBarF)+YLStatusTableCellBoder;
    
   
    
}
@end
