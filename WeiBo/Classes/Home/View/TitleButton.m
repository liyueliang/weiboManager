//
//  TitleButton.m
//  WeiBo
//
//  Created by lyl on 15/5/24.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "TitleButton.h"

#define titleButtonOfImageWidth 20
@implementation TitleButton
+(instancetype)titleButton{
    return [[self alloc]init];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted =NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.imageView.contentMode=UIViewContentModeCenter;
        self.titleLabel.textAlignment =NSTextAlignmentRight;
        self.titleLabel.font=[UIFont systemFontOfSize:19];
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX=0;
    CGFloat titleY=0;
    CGFloat titleW =contentRect.size.width-titleButtonOfImageWidth;
    CGFloat titleH=contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
 
    CGFloat imageY=0;
    CGFloat imageW =titleButtonOfImageWidth;
       CGFloat imageX=contentRect.size.width-imageW;
    CGFloat imageH=contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
     //根据title计算frame
    CGFloat titleW =  [title sizeWithFont:self.titleLabel.font].width;
    CGRect frame =self.frame;
    frame.size.width=titleButtonOfImageWidth+titleW+5;
    self.frame=frame;
    
    [super setTitle:title forState:state];
}
@end
