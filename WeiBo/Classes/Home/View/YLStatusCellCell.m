//
//  YLStatusCellCell.m
//  WeiBo
//
//  Created by jlt on 15/5/27.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLStatusCellCell.h"
#import "UIImageView+WebCache.h"
#import "YLStatusCellToolBar.h"
#import "YLReweetStatusView.h"
#import "YLStatusTopView.h"
@interface YLStatusCellCell()
@property(nonatomic,weak) YLStatusTopView *topView;//顶部view
//微博工具条
@property(nonatomic,weak) YLStatusCellToolBar *statusToolBar;
@end;
@implementation YLStatusCellCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
//        UIImageView *bgSelectedView=[[UIImageView alloc]init];
//        bgSelectedView.image =[ UIImage resizedImageWithName:@"common_card_background_highlighted"];
        self.selectedBackgroundView =[[UIView alloc]init];
        //1:添加原创微博内部的子控件
        [self setupTopSubViews];
      
        //2:添加微博的工具条
        [self setupStatusToolBar];
    }
    return self;
}
+(instancetype)cellWithTableView:(UITableView *)tableView{

    static NSString *identity =@"cell";
    YLStatusCellCell *cell =[tableView dequeueReusableCellWithIdentifier:identity];
    if (cell==nil) {
        cell =[[YLStatusCellCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)setupTopSubViews{
    //1:添加顶部控件
    YLStatusTopView *topView =[[YLStatusTopView alloc]init];
    [self.contentView addSubview:topView];
    self.topView =topView;
}

-(void)setupStatusToolBar{
    //1:添加顶部控件
    YLStatusCellToolBar *statusToolBar =[[YLStatusCellToolBar alloc]init];
  
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar =statusToolBar;
}

-(void)setStatusFrame:(YLStatusFrame *)statusFrame{
    _statusFrame =statusFrame;
    //1:设置原创微博
    [self setupOrginalData];
    //设置工具条
    [self setupToolBarData];
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x =YLStatusTableCellBoder;
    frame.origin.y+=YLStatusTableCellBoder;
    frame.size.width-=2*YLStatusTableCellBoder;
    frame.size.height-=YLStatusTableCellBoder;
    [super setFrame:frame];
}
-(void)setupOrginalData{
    self.topView.frame=self.statusFrame.topViewF;
    self.topView.statusFrame =self.statusFrame;
}

-(void)setupToolBarData{
    
    self.statusToolBar.frame =self.statusFrame.statusToolBarF;
    self.statusToolBar.status  =self.statusFrame.status;
}
@end
