//
//  YLTabBar.m
//  WeiBo
//
//  Created by lyl on 15/5/18.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLTabBar.h"
#import "YLTabBarButton.h"
@interface YLTabBar()
@property(nonatomic,weak) YLTabBarButton *selectedBtn;
@property(nonatomic,weak) UIButton *plusButton;
@property(nonatomic,strong) NSMutableArray *tabBarButtons;
@end
@implementation YLTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons==nil) {
        _tabBarButtons =[NSMutableArray arrayWithCapacity:0];
        
    }
    return _tabBarButtons;
}
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        if (!IOS7) {
            self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        //添加一个加号按钮
        UIButton *plusButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.bounds=CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}
-(void)addTabBarButtonWithItem:(UITabBarItem *)item{
    //1:创建按钮
    YLTabBarButton *button =[[ YLTabBarButton alloc]init];
    [self addSubview:button];
    
    
    //2:设置按钮属性
    button.item = item;
    //3:监听按钮事件
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    //5:添加按钮到数组中
    [self.tabBarButtons addObject:button];
    
    //4：设置第一按钮选中
    if (self.tabBarButtons.count==1) {
        [self btnClick:button];
    }
    
}
/*
    点击事件
 */
-(void)btnClick:(YLTabBarButton *)btn{
    if ([self.tabBarDelegate respondsToSelector:@selector(yltabBar:didSelectedButtonFrom:to:)]) {
        [self.tabBarDelegate yltabBar:self didSelectedButtonFrom:self.selectedBtn.tag to:btn.tag];
    }
    //设置上次选中的btn为取消状态
    self.selectedBtn.selected=NO;
    //设置当前选中的btn状态为选中
    btn.selected=YES;
    //把当前选中的按钮付给上次选中的btn
    self.selectedBtn=btn;
}
//设置
-(void)layoutSubviews{
    [super layoutSubviews];
    //调整加号按钮的位置
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    self.plusButton.center =CGPointMake(w*0.5, h*0.5);
    
    CGFloat buttonY=0;
    CGFloat buttonW =w/self.subviews.count;
    CGFloat buttonH=h;
     
    for (int index =0; index<self.tabBarButtons.count; index++) {
        
        //1:取出每个button
        YLTabBarButton *button =[self.tabBarButtons objectAtIndex:index];
        [button setTag:index];
        
        //2：设置按钮的frame
        CGFloat buttonX = index*buttonW;
        if (index>1) {
            buttonX = buttonX+buttonW;
        }
        button.frame =CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}
@end
