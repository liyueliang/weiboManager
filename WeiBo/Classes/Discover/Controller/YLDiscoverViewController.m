//
//  YLDiscoverViewController.m
//  WeiBo
//
//  Created by jlt on 15/5/23.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLDiscoverViewController.h"
#import "YLSearchBar.h"
@interface YLDiscoverViewController ()

@end

@implementation YLDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YLSearchBar *searchBar =[YLSearchBar searchBar];
    searchBar.frame=CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView =searchBar;
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
