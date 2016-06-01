//
//  exercisesTableViewCell.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/5/31.
//  Copyright © 2016年 何建新. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kFont [UIFont fontWithName:@"Arial" size:14]

#import "exercisesTableViewCell.h"

@implementation exercisesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)setInfoArray:(NSArray *)infoArray
//{
//    NSLog(@"%@",infoArray);
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kWidth-80, 40)];
//    label.font = kFont;
//    label.text = self.infoArray
//}
-(void)setInfoDic:(NSDictionary *)infoDic
{
    NSLog(@"%@",infoDic);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kWidth-80, 40)];
    label.font = kFont;
    label.text = infoDic[@"problem"];
    //栏目按钮
    UIButton *answersBtn = [[UIButton alloc] init];
    [answersBtn setTitle:infoDic[@"categoryname_e"] forState:UIControlStateNormal];
    answersBtn.backgroundColor = [UIColor whiteColor];
    CGSize titleSize = [self getStringSize:infoDic[@"categoryname_e"]];
    [answersBtn setFrame:CGRectMake(label.frame.size.width+10, 5, titleSize.width+20, 30)];
    //这只按钮圆角
    [answersBtn setFont:kFont];
    [answersBtn.layer setMasksToBounds:YES];
    [answersBtn.layer setCornerRadius:15.0];
    [answersBtn.layer setBorderWidth:1.0];
    [answersBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [answersBtn.layer setBorderColor:CGColorCreate(colorSpace, (CGFloat[]){0.8,0.8,0.8,0.8})];
    
    [self.contentView addSubview:label];
    [self.contentView addSubview:answersBtn];
}
-(CGSize)getStringSize:(NSString *)str{
    CGSize strSize = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont} context:nil].size;
    return strSize;
}
@end
