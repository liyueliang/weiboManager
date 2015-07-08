//
//  YLHomeTableViewController.m
//  WeiBo
//
//  Created by lyl on 15/5/17.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLHomeTableViewController.h"
#import "YLBadgeButton.h"
#import "TitleButton.h"
#import "AFNetworking.h"
#import "YLAccountTool.h"
#import "YLStatus.h"
#import "MJExtension.h"
#import "YLStatusFrame.h"
#import "YLStatusCellCell.h"
#import "MJRefresh.h"
#import "YLUser.h"
#define TitleButtonUpTag -1
#define TitleButtonDownTag 0
@interface YLHomeTableViewController ()
@property(nonatomic,strong) NSArray *stateuesFrameArray;
@property(nonatomic,strong) TitleButton *navTitleBtn;
@end

@implementation YLHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNavBar];
    //加载微博数据
    [self setupData];
    //加载用户信息
    [self setupUserInfo];
}
-(NSArray *)stateuesFrameArray{
    if (_stateuesFrameArray==nil) {
        _stateuesFrameArray=[NSArray array];
    }
    
    return _stateuesFrameArray;
}
-(void)setupData{
   // [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(setupStates)];
    //[self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(setupStates)];
    
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        
         [self setupStates:@"up"];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [self setupStates:@"down"];
        
    }];
    [self.tableView.legendHeader beginRefreshing];
}
-(void)setupUserInfo{
    //创建请求管理对象
    AFHTTPRequestOperationManager *mgr =[AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    YLAccount *tempAccount =[YLAccountTool account];
    [params setObject:tempAccount.access_token forKey:@"access_token"];
    [params setObject:[NSString stringWithFormat:@"%lld", tempAccount.uid] forKey:@"uid"];
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        YLUser *user =[YLUser objectWithKeyValues:responseObject];
        [self.navTitleBtn setTitle:user.name forState:UIControlStateNormal];
        //保存昵称
        YLAccount *account =[YLAccountTool account];
        account.name =user.name;
        [YLAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
-(void)setupStates:(NSString *)commandName{
 
    //创建请求管理对象
    AFHTTPRequestOperationManager *mgr =[AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    YLAccount *tempAccount =[YLAccountTool account];
    [params setObject:tempAccount.access_token forKey:@"access_token"];
    if ([commandName isEqualToString:@"up"]) {
        YLStatusFrame *firstStatusFrame =[self.stateuesFrameArray firstObject];
        if (firstStatusFrame) {
            [params setObject:firstStatusFrame.status.idstr forKey:@"since_id"];
        }
    }else{
        YLStatusFrame *firstStatusFrame =[self.stateuesFrameArray lastObject];
        long long idStr = [firstStatusFrame.status.idstr longLongValue]-1;
        [params setObject:[NSString stringWithFormat:@"%lld",idStr] forKey:@"max_id"];
        
    }
  
    
    //发送请求
    //NSString *getUrl =[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@",tempAccount.access_token];
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *dictArray = [responseObject objectForKey:@"statuses"];
        
//        NSMutableArray *statusArray =[NSMutableArray arrayWithCapacity:0];
//        for (NSDictionary *dict in dictArray) {
//            //创建模型
//            YLStatus *status =[YLStatus objectWithKeyValues:dict];
//            //添加模型
//            [statusArray addObject:status];
//        }
        //获取新浪服务器返回的数据转换为模型数据列表
        NSArray *statusArray = [YLStatus objectArrayWithKeyValuesArray:dictArray];
        NSMutableArray *tempStatusFrameArray =[NSMutableArray arrayWithCapacity:0];
        for (YLStatus  *itemStatus in statusArray) {
             
            //将每一个数据模型装载到cellframe对象中
            YLStatusFrame *statusFrame =[[YLStatusFrame alloc]init];
            statusFrame.status = itemStatus;
            [tempStatusFrameArray addObject:statusFrame];
        }
        NSMutableArray *tempStatusArray =[NSMutableArray arrayWithCapacity:0];
        if ([commandName isEqualToString:@"up"]) {
            
            [tempStatusArray addObjectsFromArray:tempStatusFrameArray];
            [tempStatusArray addObjectsFromArray:self.stateuesFrameArray];
               self.stateuesFrameArray = tempStatusArray;

        }else{
            
            [tempStatusArray addObjectsFromArray:self.stateuesFrameArray];
            [tempStatusArray addObjectsFromArray:tempStatusFrameArray];
            self.stateuesFrameArray =tempStatusArray;
            
        }
        
        //刷新表格
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        //显示有多少数据加载出来
        [self showNewStatausCount:tempStatusFrameArray.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        YLLog(@"responseObject:%@",[error localizedDescription]);
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}
-(void)showNewStatausCount:(int)count{
    //创建uibutton
    UIButton *btn =[[UIButton alloc]init];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    //设置btn属性
    btn.userInteractionEnabled=NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    if (count) {
        NSString *title =[NSString stringWithFormat:@"共有%d条新的微博",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    //设置按钮的frame
    CGFloat btnH=30;
    CGFloat btnY =64-btnH;
    CGFloat btnX =0;
     CGFloat btnW =self.view.frame.size.width;
    btn.frame =CGRectMake(btnX, btnY, btnW, btnH);
    //设置动画
    [UIView animateWithDuration:0.7 animations:^{
        //向下移动btn
        btn.transform=CGAffineTransformMakeTranslation(0, btnH+1);
    } completion:^(BOOL finished) {
        //向上移动btn
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform=CGAffineTransformIdentity;//清空transform
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
            
        }];
//        [UIView animateKeyframesWithDuration:0.7 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
//            btn.transform=CGAffineTransformIdentity;//清空transform
//
//        } completion:^(BOOL finished) {
//            [btn removeFromSuperview];
//            
//        }];
    }];
}
-(void)setupNavBar{
    
    //左边按钮
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem  itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    //右边按钮
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self  action:@selector(pop)];
    //添加导航栏中间视图
    TitleButton *titleButton =[TitleButton titleButton];
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.bounds=CGRectMake(0, 0, 0, 30);
    NSString *titleName =@"首页";
    if ([YLAccountTool account].name) {
        titleName =[YLAccountTool account].name;
    }
    [titleButton setTitle:titleName forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView =titleButton;
    self.navTitleBtn =titleButton;
    
    self.tableView.backgroundColor=ylColor(226, 226, 226);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, YLStatusTableCellBoder, 0);
    
    
    
    
}
-(void)titleButtonClick:(UIButton *)btnObj{
    if (btnObj.tag==TitleButtonDownTag) {
        [btnObj setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        btnObj.tag=TitleButtonUpTag;
    }else{
        [btnObj setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        btnObj.tag = TitleButtonDownTag;
    }
}
-(void)pop

{
    YLLog(@"pop");
}
-(void)findFriend{
    YLLog(@"findFriend");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.stateuesFrameArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLStatusFrame *statusFrame = [self.stateuesFrameArray objectAtIndex:indexPath.row];
    return statusFrame.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLStatusCellCell *cell =[YLStatusCellCell cellWithTableView:tableView];
        //设置cell的数据
    YLStatusFrame *statusFrame  =[self.stateuesFrameArray objectAtIndex:indexPath.row];
    cell.statusFrame = statusFrame;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *customerVC   = [[UIViewController alloc]init];
    [customerVC.view setBackgroundColor:[UIColor redColor]];
    [self.navigationController pushViewController:customerVC animated:YES];
}
 
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
