//
//  YLStatus.m
//  WeiBo
//
//  Created by jlt on 15/5/27.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLStatus.h"
#import "NSDate+YL.h"
#import "MJExtension.h"
#import "YLPhoto.h"
@implementation YLStatus
//+(instancetype)statusWithDict:(NSDictionary *)dict{
//    return [[self alloc]initWithDict:dict];
//}
//-(instancetype)initWithDict:(NSDictionary *)dict{
//    if (self=[super init]) {
//        self.idstr =[dict objectForKey:@"idstr"];
//        self.text=[dict objectForKey:@"text"];
//        self.source =[dict objectForKey:@"source"];
//        self.reposts_count =[[dict objectForKey:@"reposts_count"] intValue];
//        self.comments_count =[[dict objectForKey:@"comments_count"] intValue];
//        self.user =[YLUser userWithDict:[dict objectForKey:@"user"]] ;
//    }
//    return self;
//}
-(NSDictionary *)objectClassInArray{
    return [NSDictionary dictionaryWithObject:[YLPhoto class] forKey:@"pic_urls"];
}
-(void)setSource:(NSString *)source{
    _source = source; 
    if (source.length>0) {
        long startLoc =[source rangeOfString:@">"].location+1 ;
        long endLoc =[source rangeOfString:@"</"].location;
        long lengt = endLoc-startLoc;
        NSString *tempSoure =[source substringWithRange:NSMakeRange(startLoc, lengt)];
        
        _source = [NSString stringWithFormat:@"来源:%@",tempSoure];
    }
 
}
-(NSString *)created_at{
    NSDateFormatter *fmt= [[NSDateFormatter alloc]init];
    fmt.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createDate =[fmt dateFromString:_created_at];
     
    //今天
    if (createDate.isToday) {
        if (createDate.deltaWithNow.hour>=1) {
            return [NSString stringWithFormat:@"%ld小时前",createDate.deltaWithNow.hour];
        }else if (createDate.deltaWithNow.minute>=1) {
            return [NSString stringWithFormat:@"%ld分钟前",createDate.deltaWithNow.minute];
        }else{
            return @"刚刚";
        }
    }else if(createDate.isYesterday){//昨天
        fmt.dateFormat =@"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    }else if(createDate.isYesterday){//今年
        fmt.dateFormat =@"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }else{//非今年
        fmt.dateFormat=@"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
    //前天更早
    //去年
    
    return @"刚刚";
}
@end
