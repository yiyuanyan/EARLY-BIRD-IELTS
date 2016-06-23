//
//  PostDetailsViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/6/14.
//  Copyright © 2016年 何建新. All rights reserved.
//
/*学校帖子详情页面
 http://testapp.benniaoyasi.com/api.php?appid=1&m=api&devtype=android&uuid=123&version=2.0&mobile=&uid=&c=Nbbs&a=infoBbs&id=79
 */

#import "PostDetailsViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "JSONKit.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kFont [UIFont fontWithName:@"Arial" size:14]
@interface PostDetailsViewController ()<MBProgressHUDDelegate>
@property(nonatomic, assign)NSMutableDictionary *infoDic;
@property (strong, nonatomic) MBProgressHUD *hud;
@property(nonatomic, strong)UIScrollView *scrollView;

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] init];
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    self.hud.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    //获取页面数据
    NSString *url = [NSString stringWithFormat:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&devtype=android&uuid=Anv7Hq60Kbtx73UOYk-8j_Z_Mw8Q3pCP8avAGO7Z22HR&version=2.0&mobile=15810910848&uid=182676&c=Nbbs&a=infoBbs&id=%@",self.postId];
    NSLog(@"%@",url);
    //http://testapp.benniaoyasi.com/api.php?appid=1&m=api&devtype=android&uuid=Anv7Hq60Kbtx73UOYk-8j_Z_Mw8Q3pCP8avAGO7Z22HR&version=2.0&mobile=15810910848&uid=182676&c=Nbbs&a=infoBbs&id=94
    [self getNetWorkingJSON:url requestType:@"contentView"];
    [self.view addSubview:self.scrollView];
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
#pragma mark --自定义方法
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getNetWorkingJSON:(NSString *)url requestType:(NSString *)requestType{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
               
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"ecode"] isEqualToString:@"0"]){
            if([requestType isEqualToString:@"contentView"]){
                
                [self createContentView:responseObject[@"edata"]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               
    }];
    
}
-(void)createContentView:(NSMutableDictionary *)infoDic{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, kWidth, 300)];
    
    UIView *userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    //获取图片
    UIImageView *userPic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 40, 40)];
    [userPic sd_setImageWithURL:infoDic[@"uimage"]];
    //设置图片为圆形
    userPic.layer.masksToBounds = YES;
    userPic.layer.cornerRadius = userPic.bounds.size.width * 0.5;
    //设置图片边框
    //userPic.layer.borderWidth = 5.0;
    //userPic.layer.borderColor = [UIColor whiteColor].CGColor;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 40)];
    nameLabel.text = infoDic[@"uname"];
    nameLabel.font = kFont;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-70, 0, 60, 40)];
    timeLabel.text = infoDic[@"create_time_geshi"];
    timeLabel.font = kFont;
    timeLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    //考试时间
    UIImageView *timeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_social_time"]];
    [timeImageView setFrame:CGRectMake(10, 75, 20, 20)];
    UILabel *examTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 75, kWidth-50, 20)];
    examTimeLabel.text = [NSString stringWithFormat:@"考试时间：%@",infoDic[@"exam_time"]];
    examTimeLabel.font = [UIFont fontWithName:@"Arial" size:12];
    //考试地点
    UIImageView *examPlacePic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_position"]];
    [examPlacePic setFrame:CGRectMake(10, 115, 20, 20)];
    UILabel *examPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 115, kWidth-50, 20)];
    examPlaceLabel.text = [NSString stringWithFormat:@"考试地点：%@",infoDic[@"school_name"]];
    examPlaceLabel.font = [UIFont fontWithName:@"Arial" size:12];
    //part1
    
    UILabel *part1 = [[UILabel alloc] initWithFrame:CGRectMake(35, examPlaceLabel.frame.origin.y+examPlaceLabel.frame.size.height+15, 50, 30)];
    part1.text = @"Part1";
    part1.font = [UIFont fontWithName:@"Arial" size:12];
    CGSize part1StrSize = [self getStringSize:infoDic[@"p1name"]];
    float Part1BtnW = 0.0;
    if((part1StrSize.width+30) > (kWidth - (part1.frame.origin.x+part1.frame.size.width+35))){
        Part1BtnW = kWidth - (part1.frame.origin.x+part1.frame.size.width+10);
    }else{
        Part1BtnW = part1StrSize.width+30;
    }
    UIButton *part1Btn = [[UIButton alloc] initWithFrame:CGRectMake(part1.frame.origin.x+part1.frame.size.width, part1.frame.origin.y, Part1BtnW, 30)];
    part1Btn.font = [UIFont fontWithName:@"Arial" size:12];
    part1Btn.backgroundColor = [UIColor blueColor];
    [part1Btn setTitle:infoDic[@"p1name"] forState:UIControlStateNormal];
    [part1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    part1Btn.backgroundColor = [UIColor whiteColor];
    [part1Btn.layer setMasksToBounds:YES];
    [part1Btn.layer setCornerRadius:10.0];
    [part1Btn.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [part1Btn.layer setBorderColor:CGColorCreate(colorSpace, (CGFloat[]){200/255.0,200/255.0,200/255.0,1})];
    
    
    
    //part2
    UILabel *part2 = [[UILabel alloc] initWithFrame:CGRectMake(35, examPlaceLabel.frame.origin.y+examPlaceLabel.frame.size.height+60, 50, 30)];
    part2.text = @"Part2";
    part2.font = [UIFont fontWithName:@"Arial" size:12];
    CGSize part2StrSize = [self getStringSize:infoDic[@"p2name"]];
    float Part2BtnW = 0.0;
    if((part2StrSize.width+30) > (kWidth - (part2.frame.origin.x+part2.frame.size.width+35))){
        Part2BtnW = kWidth - (part2.frame.origin.x+part2.frame.size.width+10);
    }else{
        Part2BtnW = part2StrSize.width+30;
    }
    
    UIButton *part2Btn = [[UIButton alloc] initWithFrame:CGRectMake(part2.frame.origin.x+part2.frame.size.width, part2.frame.origin.y, Part2BtnW, 30)];
    part2Btn.font = [UIFont fontWithName:@"Arial" size:12];
    [part2Btn setTitle:infoDic[@"p2name"] forState:UIControlStateNormal];
    [part2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    part2Btn.backgroundColor = [UIColor whiteColor];
    [part2Btn.layer setMasksToBounds:YES];
    [part2Btn.layer setCornerRadius:10.0];
    [part2Btn.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    [part2Btn.layer setBorderColor:CGColorCreate(colorSpace2, (CGFloat[]){200/255.0,200/255.0,200/255.0,1})];
    [contentView setFrame:CGRectMake(0, -64, kWidth, part2Btn.frame.origin.y+part2Btn.frame.size.height+10)];
    
    //contentLabel
    UILabel *contentLabel = [[UILabel alloc] init];
    if(![infoDic[@"content"] isEqualToString:@""]){
        CGSize contentSize = [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:infoDic[@"content"]];

        [contentLabel setFrame:CGRectMake(5, part2Btn.frame.origin.y+part2Btn.frame.size.height+10, kWidth-10, contentSize.height)];
        contentLabel.numberOfLines = 0;
        contentLabel.font = kFont;
        contentLabel.text = infoDic[@"content"];
        contentLabel.textColor = [UIColor blackColor];
        [contentView addSubview:contentLabel];
        [contentView setFrame:CGRectMake(0, -64, kWidth, contentLabel.frame.origin.y+contentLabel.frame.size.height+10)];
    }
    float imgY = contentLabel.frame.origin.y+contentLabel.frame.size.height+10;
    NSLog(@"%f",imgY);
    UIView *imagesView = [[UIView alloc] initWithFrame:CGRectMake(0, contentLabel.frame.origin.y+contentLabel.frame.size.height, kWidth, 100)];
    float imagesViewHeight = 0.0;
    for(int i = 0;i<[infoDic[@"images"] count]; i++){
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:infoDic[@"images"][i][@"middle_image"]];
        //NSString *imageSize = NSStringFromCGSize(imageView.image.size);
        NSLog(@"%f",imageView.image.size.height);
        NSLog(@"%f",imageView.image.size.width);
        if(i == 0){
            
        }else{
            imgY += imageView.image.size.height+5;
            imagesViewHeight += imgY;
            
        }
        [imageView setFrame:CGRectMake(10, imgY, imageView.image.size.width, imageView.image.size.height)];
        [imagesView setFrame:CGRectMake(0, contentLabel.frame.origin.y+contentLabel.frame.size.height, kWidth, imagesViewHeight)];
        [imagesView addSubview:imageView];
        
        i++;
        
    }
    
    
    
    [contentView addSubview:imagesView];
    [contentView addSubview:part2Btn];
    [contentView addSubview:part2];
    [contentView addSubview:part1Btn];
    [contentView addSubview:part1];
    [contentView addSubview:examPlaceLabel];
    [contentView addSubview:examPlacePic];
    [contentView addSubview:examTimeLabel];
    [contentView addSubview:timeImageView];
    [userView addSubview:timeLabel];
    [userView addSubview:nameLabel];
    [userView addSubview:userPic];
    [contentView addSubview:userView];
    //[self.scrollView setFrame:CGRectMake(0, 64, kWidth, contentView.frame.size.height)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(0, contentView.frame.size.height*2);
    [self.scrollView addSubview:contentView];
}
//获取字符串的SIZE
-(CGSize)getStringSize:(NSString *)string{
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont} context:nil].size;
    return strSize;
}
- (CGSize)boundingRectWithSize:(CGSize)size string:(NSString *)string
{
    NSDictionary *attribute = @{NSFontAttributeName: kFont};
    
    CGSize retSize = [string boundingRectWithSize:size
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return retSize;
}
@end
