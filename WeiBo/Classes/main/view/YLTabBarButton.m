//
//  YLTabBarButton.m
//  WeiBo
//
//  Created by lyl on 15/5/18.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#define YLTabBarButtonImageRatio 0.6
#import "YLTabBarButton.h"
#import "YLBadgeButton.h"

#define YLTabBarButtonTitleColor (IOS7?[UIColor blackColor]:[UIColor whiteColor])
#define YLTabBarButtonTitleSelectColor (IOS7?[UIColor orangeColor]:ylColor(248,139,0))
@interface YLTabBarButton()
@property(nonatomic,weak) YLBadgeButton *bageButton;
@end
@implementation YLTabBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        //设置image 居中
        self.imageView.contentMode =UIViewContentModeCenter;
        //设置文本居中
        self.titleLabel.textAlignment =NSTextAlignmentCenter;
        //设置文本字号
        self.titleLabel.font =[UIFont systemFontOfSize:11];
        [self setTitleColor:YLTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:YLTabBarButtonTitleSelectColor forState:UIControlStateSelected];
        if (!IOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
            
        }
        //添加i个提醒数字按钮
        YLBadgeButton *bageButton =[YLBadgeButton buttonWithType:UIButtonTypeCustom];
        bageButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
          [self addSubview:bageButton];
        self.bageButton = bageButton;
        
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*YLTabBarButtonImageRatio);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY =contentRect.size.height-contentRect.size.height*YLTabBarButtonImageRatio;
    return CGRectMake(0, titleY, contentRect.size.width, contentRect.size.height- titleY);
}
-(void)setItem:(UITabBarItem *)item{
    _item =item;

    //kvo 监听属性改变(title)
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    //设置提醒数字
    self.bageButton.badgeValue = self.item.badgeValue;
    //设置提醒数字的位置
    CGFloat badgeY =3;
    CGFloat badgeX = self.frame.size.width - self.bageButton.frame.size.width -5;
    CGRect badgeF = self.bageButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.bageButton.frame =badgeF;
        
}
-(void)dealloc{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}
@end
