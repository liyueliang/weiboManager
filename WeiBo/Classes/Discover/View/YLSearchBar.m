//
//  YLSearchBar.m
//  WeiBo
//
//  Created by jlt on 15/5/23.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLSearchBar.h"

@implementation YLSearchBar

+(instancetype)searchBar{
    return [[self alloc]init];
}
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.background=[UIImage resizedImageWithName:@"searchbar_textfield_background"];
        
        //左边放大镜
        UIImageView *iconView =[[UIImageView alloc]initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        self.leftView= iconView;
          self.leftViewMode =UITextFieldViewModeAlways;
        //右边清除按钮
        iconView.contentMode =UIViewContentModeCenter;
        //设置提醒文字
        self.font=[UIFont systemFontOfSize:12];
        self.clearButtonMode =UITextFieldViewModeAlways;
        NSMutableDictionary *attrs =[NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] =[UIColor grayColor];
        
        self.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"搜索" attributes:attrs];
        //设置键盘右下角按钮的样式
        self.returnKeyType =UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
      
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置左边图标的frame
    self.leftView.bounds=CGRectMake(0, 0, 30, self.frame.size.height);
}
@end
