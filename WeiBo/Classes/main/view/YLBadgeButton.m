//
//  YLBadgeButton.m
//  WeiBo
//
//  Created by jlt on 15/5/23.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLBadgeButton.h"

@implementation YLBadgeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden=YES;
        [self setUserInteractionEnabled:NO];
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:11];
    }
    return self;
}
-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue =[badgeValue  copy];
    if (badgeValue) {
        self.hidden =NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        //设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW =self.currentBackgroundImage.size.width;
        if (badgeValue.length>1) {
            //文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width +10;
        }
        frame.size.width =badgeW;
        frame.size.height=badgeH;
        self.frame =frame;
    }else{
        self.hidden=YES;
    }

}
@end
