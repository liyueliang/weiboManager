//
//  YLCustomerTabController.m
//  WeiBo
//
//  Created by lyl on 15/5/17.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLCustomerTabController.h"
#import "YLHomeTableViewController.h"
#import "YLMessageTableViewController.h"
#import "YLDiscoverViewController.h"
#import "YLMeViewController.h"
#import "UIImage+adaptation.h"
#import "YLTabBar.h"
#import "YLCustomerNavViewController.h"
@interface YLCustomerTabController ()<YLTabBarDelegate>
@property(nonatomic,strong) YLTabBar *customerTabBar;
@end

@implementation YLCustomerTabController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //创建自定义tabbar
    [self initCustomerTabBar];
    //初始化子控制器
    [self initAllChilderController];
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //删除系统自动生成的uitabbarbutton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
-(void)initCustomerTabBar{
    YLTabBar *customerTabBar =[[YLTabBar alloc]init];
    customerTabBar.frame=self.tabBar.bounds;
    customerTabBar.tabBarDelegate = self;
    [self.tabBar addSubview:customerTabBar]; 
    self.customerTabBar =customerTabBar;
}

-(void)initAllChilderController{
    YLHomeTableViewController *homeVC =[[YLHomeTableViewController alloc]init];
   homeVC.tabBarItem.badgeValue=@"1";
    [self initChilderControler:homeVC withTitle:@"首页" withImageName:@"tabbar_home" withSelectImageName:@"tabbar_home_selected"];
    
    YLMessageTableViewController *messageVC =[[YLMessageTableViewController alloc]init];
    messageVC.tabBarItem.badgeValue=@"100";
    [self initChilderControler:messageVC withTitle:@"消息" withImageName:@"tabbar_message_center" withSelectImageName:@"tabbar_message_center_selected"];
    
    YLDiscoverViewController *discoverVC =[[YLDiscoverViewController alloc]init];
    discoverVC.tabBarItem.badgeValue=@"10";
    [self initChilderControler:discoverVC withTitle:@"广场" withImageName:@"tabbar_discover" withSelectImageName:@"tabbar_discover_selected"];
    
    YLMeViewController *meVC =[[YLMeViewController alloc]init];
    meVC.tabBarItem.badgeValue=@"99+";
    [self initChilderControler:meVC withTitle:@"我" withImageName:@"tabbar_profile" withSelectImageName:@"tabbar_profile_selected"];
}
-(void)initChilderControler:(UIViewController *)childerVC withTitle:(NSString *)title withImageName:(NSString *)imageName withSelectImageName:(NSString *)selectImageName{
    childerVC.title=title;
    
    
    childerVC.tabBarItem.image=[UIImage imageWithName:imageName]; 
    UIImage *selectedImage =[UIImage imageWithName:selectImageName];
    if (IOS7) {
        childerVC.tabBarItem.selectedImage=[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; ;
    }else{
     childerVC.tabBarItem.selectedImage=selectedImage ;
    }
   
  
    YLCustomerNavViewController *navVC =[[YLCustomerNavViewController alloc]initWithRootViewController:childerVC];
    
    [self addChildViewController:navVC];
    
    //添加自定义tabbar
    [self.customerTabBar addTabBarButtonWithItem:childerVC.tabBarItem];
}
#pragma mark --yltabbardelegate
-(void)yltabBar:(YLTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    self.selectedIndex =to;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
