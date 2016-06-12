//
//  IntelligenceTableViewCell.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/6/7.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IntelligenceTableViewCell.h"
//#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation IntelligenceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)setInfo:(NSMutableArray *)info
//{
//    NSLog(@"%@",info);
//    
//    
//}
-(void)setInfo:(NSMutableDictionary *)info
{
    //NSLog(@"%@",info);
    //头像、名称、学校和时间的容器
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 65)];
    //头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    if(info[@"uimage"] != nil){
        [headImageView sd_setImageWithURL:[NSURL URLWithString:info[@"uimage"]]];
    }
    [titleView addSubview:headImageView];
    //名称
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, kWidth-120, 20)];
    nameLabel.font = [UIFont fontWithName:@"Arial" size:14];
    nameLabel.text = info[@"uname"];
    [titleView addSubview:nameLabel];
    //学校
    UILabel *schoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, kWidth-120, 20)];
    schoolLabel.font = [UIFont fontWithName:@"Arial" size:14];
    schoolLabel.text = info[@"school_name"];
    [titleView addSubview:schoolLabel];
    //时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-70, 15, 60, 20)];
    timeLabel.font = [UIFont fontWithName:@"Arial" size:14];
    timeLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    timeLabel.text = info[@"create_time_geshi"];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:timeLabel];
    //内容
    CGSize strSize = [self getStringSize:info[@"content"]];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, headImageView.frame.origin.y+headImageView.frame.size.height+5, kWidth-10, strSize.height)];
    contentLabel.text = info[@"content"];
    contentLabel.font = [UIFont fontWithName:@"Arial" size:14];
    contentLabel.numberOfLines = 0;
    NSLog(@"%lu",[info[@"images"] count]);
    int imageCount = (int)[info[@"images"] count];
    if(imageCount == 1){
        //一张图片
        
    }else if(imageCount > 1 && imageCount < 4){
        //2~3张图片
    
    }else if(imageCount > 3 && imageCount < 7){
        //4~6张图片
    }
    
    
    //内容
    [self.contentView addSubview:contentLabel];
    //头像、名称、学校和时间的容器
    [self.contentView addSubview:titleView];
}
//计算文本SIZE
-(CGSize)getStringSize:(NSString *)string{
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:14]} context:nil].size;
    return strSize;
}
@end
