//
//  YLNewfeatureViewController.m
//  WeiBo
//
//  Created by lyl on 15/5/25.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLNewfeatureViewController.h"
#import "YLCustomerTabController.h"
#define newFeatureImageCount 3
@interface YLNewfeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak) UIPageControl *pageControl;
@end

@implementation YLNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加scrollerview
    [self setupScrollerView];
    //添加pageControl
    [self setupPageControl];
}
-(void)setupScrollerView{
    UIScrollView *scrollView =[[UIScrollView alloc]init];
    scrollView.frame=self.view.bounds;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    //2:添加图片
    CGFloat imageW =scrollView.frame.size.width;
    CGFloat imageH =scrollView.frame.size.height;
    for (int i=0; i<newFeatureImageCount; i++) {
        NSString *name =nil;
        if (fourInch) {
            name =[NSString stringWithFormat:@"new_feature_%d-568h",i+1];
        }else{
            name =[NSString stringWithFormat:@"new_feature_%d",i+1];
        }
        
        UIImageView *itemImageView =[[UIImageView alloc]initWithImage:[UIImage imageWithName:name]];
        CGFloat imageX = imageW*i;
        itemImageView.frame=CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:itemImageView];
        if (i==newFeatureImageCount-1) {
            [self setupLastImageView:itemImageView];
        }
    }
    //3:设置contentsize
    scrollView.contentSize =CGSizeMake(imageW*newFeatureImageCount, 0);
    scrollView.pagingEnabled=YES;
    scrollView.bounces=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    }
-(void)setupPageControl{
    //添加pagecontrol
    UIPageControl *pageControl =[[UIPageControl alloc]init];
    pageControl.numberOfPages =newFeatureImageCount;
    CGFloat centerX =self.view.frame.size.width*0.5;
    CGFloat centerY=self.view.frame.size.height-30;
    pageControl.center =CGPointMake(centerX, centerY);
    pageControl.bounds=CGRectMake(0, 0, 100, 30);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    //设置原点的颜色
    pageControl.currentPageIndicatorTintColor =ylColor(253, 98, 42);
    
    pageControl.pageIndicatorTintColor =ylColor(189, 189, 189);
    
}
-(void)setupLastImageView:(UIImageView *)imageView{
    imageView.userInteractionEnabled=YES;
    //添加开始按钮
    UIButton *startButton =[[ UIButton alloc]init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startButton.center=CGPointMake(imageView.frame.size.width*0.5, imageView.frame.size.height*0.6);
    startButton.bounds=CGRectMake(0, 0, startButton.currentBackgroundImage.size.width, startButton.currentBackgroundImage.size.height);
    //设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    //添加checkbox
    UIButton *checkbox =[[UIButton alloc]init];
    checkbox.selected =YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds=startButton.bounds;
    checkbox.center=CGPointMake(imageView.frame.size.width*0.5, imageView.frame.size.height*0.5);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font= [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkbox];
}

-(void)start{
     
    self.view.window.rootViewController =[[YLCustomerTabController alloc]init];
}
-(void)checkboxClick:(UIButton *)checkbox{
    checkbox.selected = !checkbox.isSelected;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //1:取出水平方向滚动距离
    CGFloat offsetX =scrollView.contentOffset.x;
    //2:求出页码
    double pageDouble =  offsetX/scrollView.frame.size.width;
    int page =(int)(pageDouble + 0.5);
    self.pageControl.currentPage =page;
    
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
