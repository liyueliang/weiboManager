//
//  YLStatusCellCell.h
//  WeiBo
//
//  Created by jlt on 15/5/27.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLStatusFrame.h"
@interface YLStatusCellCell : UITableViewCell
@property(nonatomic,strong) YLStatusFrame *statusFrame;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
