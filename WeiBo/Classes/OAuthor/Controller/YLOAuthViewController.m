//
//  YLOAuthViewController.m
//  WeiBo
//
//  Created by jlt on 15/5/25.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLOAuthViewController.h"
#import "AFNetworking.h"
#import "YLAccount.h"
#import "YLCustomerTabController.h"
#import "YLNewfeatureViewController.h"
#import "YLTool.h"
#import "YLAccountTool.h"
#import "MBProgressHUD+MJ.h"
//214884588   6c4c326a4947501dbc84189acd7a888a
#define  weibo_apikey @"214884588"
#define  weibo_apisecert @"6c4c326a4947501dbc84189acd7a888a"
@interface YLOAuthViewController ()<UIWebViewDelegate>

@end

@implementation YLOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加webview
    UIWebView *webView =[[UIWebView alloc]init];
    webView.frame=self.view.bounds;
    webView.delegate=self;
    [self.view addSubview:webView];
    //214884588
    //加载授权页面
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=http://www.baidu.com",weibo_apikey]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"加载中..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //1:
    NSString *urlStr =request.URL.absoluteString;
    NSRange range =[urlStr rangeOfString:@"code="];
    if (range.length) {
        int loc =range.location + range.length;
        NSString *code =[urlStr substringFromIndex:loc];
        
        [self accessTokenWithCode:code];
        return NO;
    }
    
    return YES;
}
-(void)accessTokenWithCode:(NSString *)code{
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    //214884588   6c4c326a4947501dbc84189acd7a888a
    
    [params setObject:weibo_apikey forKey:@"client_id"];
    [params setObject:weibo_apisecert forKey:@"client_secret"];
    [params setObject:@"authorization_code" forKey:@"grant_type"];
    [params setObject:code forKey:@"code"];
    [params setObject:@"http://www.baidu.com" forKey:@"redirect_uri"];
    AFHTTPRequestOperationManager *mgr =[AFHTTPRequestOperationManager manager];
    //mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          NSString *acctonKen =[responseObject objectForKey:@"access_token"];
          //存储accessToken信息
          YLAccount *account =[YLAccount accountWithDict:responseObject];
          [YLAccountTool saveAccount:account];
          
          [YLTool chooseRootController];
          [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YLLog(@"请求失败%@",[error localizedDescription]);
        [MBProgressHUD hideHUD];
    }];
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
