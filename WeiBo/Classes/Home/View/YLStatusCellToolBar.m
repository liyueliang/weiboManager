//
//  YLStatusCellToolBar.m
//  WeiBo
//
//  Created by jlt on 15/5/28.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLStatusCellToolBar.h"
@interface YLStatusCellToolBar()
@property(nonatomic,strong) NSMutableArray *btns;
@property(nonatomic,strong) NSMutableArray *deviders;
@property(nonatomic,weak) UIButton *reweetBtn;
@property(nonatomic,weak) UIButton *commentBtn;
@property(nonatomic,weak) UIButton *attitudeBtn;
@end
@implementation YLStatusCellToolBar
-(NSMutableArray *)deviders{
    if (_deviders==nil) {
        _deviders=[NSMutableArray array];
    }
    return _deviders;
}
-(NSMutableArray *)btns{
    if (_btns==nil) {
        _btns=[NSMutableArray array];
    }
    return _btns;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUserInteractionEnabled:YES];
        
        [self setImage:[UIImage resizedImageWithName:@"timeline_card_bottom_background"]];
        [self setHighlightedImage:[UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"]];
        
        //添加按钮
        self.reweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted" action:nil];
        self.commentBtn= [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted" action:nil];
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted" action:nil];
        //添加分割线
        [self setupDevider];
        [self setupDevider];
    }
    return self;
}
-(void)setupDevider{
    UIImageView *devider =[[UIImageView alloc]init];
    devider.image=[UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:devider];
    [self.deviders addObject:devider];
}
-(UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)imageName bgImage:(NSString *)bgImage action:(SEL)action{
    UIButton *btn  = [[UIButton alloc]init];
    [btn setImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted=NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnY=0;
    CGFloat btnH =self.frame.size.height;
    int btnCount = self.btns.count ;
     CGFloat dividerW=2;
    CGFloat btnX=0;
    CGFloat btnW =(self.frame.size.width-self.deviders.count*dividerW)/btnCount;
    for (int i=0; i<btnCount; i++) {
       UIButton *btn =[self.btns objectAtIndex:i];
        btnX = i*(btnW+dividerW);
        btn.frame=CGRectMake(btnX,btnY, btnW, btnH);
    }
    int dividerCount = self.deviders.count;
    CGFloat dividerH=btnH;
   
    CGFloat dividerX=0;
    CGFloat dividerY=btnY;
    for (int i=0; i<dividerCount; i++) {
        UIImageView *divider =[self.deviders objectAtIndex:i];
        UIButton *btn =[self.btns objectAtIndex:i];
        dividerX= CGRectGetMaxX(btn.frame);
        divider.frame=CGRectMake(dividerX,dividerY, dividerW,dividerH);
    }
    
}
-(void)setStatus:(YLStatus *)status{
    _status =status;
    //设置转发数
    [self setupBtn:self.reweetBtn Title:@"转发" count:status.reposts_count];
    //设置评论数
    [self setupBtn:self.commentBtn Title:@"评论" count:status.comments_count];
    //点赞
    [self setupBtn:self.attitudeBtn Title:@"赞" count:status.attitudes_count];
}
-(void)setupBtn:(UIButton *)btn Title:(NSString *)originalTitle count:(int)count{
    if (count) {
         NSString *title=nil;
        if (count<10000) {
            title =[NSString stringWithFormat:@"%d",count];
        }else{ //>=1w
            double countDouble = count/10000.0;
            title =[NSString stringWithFormat:@"%.1f万",countDouble];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}
@end
