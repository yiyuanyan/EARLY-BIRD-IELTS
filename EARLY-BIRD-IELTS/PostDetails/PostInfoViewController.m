//
//  PostInfoViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/6/17.
//  Copyright © 2016年 何建新. All rights reserved.
//
/*
 http://testapp.benniaoyasi.com/api.php?appid=1&m=api&devtype=android&uuid=Anv7Hq60Kbtx73UOYk-8j_Z_Mw8Q3pCP8avAGO7Z22HR&version=2.0&mobile=15810910848&uid=182676&c=Nbbs&a=infoBbs&id=94
 */

#import "PostInfoViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kFont [UIFont fontWithName:@"Arial" size:14]
@interface PostInfoViewController ()
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation PostInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, [UIScreen mainScreen].bounds.size.height)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor redColor];
    
    NSString *url = [NSString stringWithFormat:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&devtype=android&uuid=Anv7Hq60Kbtx73UOYk-8j_Z_Mw8Q3pCP8avAGO7Z22HR&version=2.0&mobile=15810910848&uid=182676&c=Nbbs&a=infoBbs&id=%@",self.postId];
    [self getNetWorkingJSON:url requestType:@"contentView"];
    
    
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
                //NSLog(@"%@",responseObject[@"edata"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
//获取文字Size
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
//创建帖子详情内容页面
-(void)createContentView:(NSDictionary *)info{
    NSLog(@"%@",info);
    //头像
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, -64, 40, 40)];
    [userImageView sd_setImageWithURL:[NSURL URLWithString:info[@"uimage"]]];
    userImageView.layer.masksToBounds = YES;
    userImageView.layer.cornerRadius = userImageView.bounds.size.width * 0.5;
    [self.scrollView addSubview:userImageView];
    //名称
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(60, -64, [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:info[@"uname"]].width+10, 40)];
    userName.font = kFont;
    userName.text = info[@"uname"];
    [self.scrollView addSubview:userName];
    //发帖时间
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-[self boundingRectWithSize:CGSizeMake(kWidth, 0) string:info[@"create_time_geshi"]].width-20, -64, [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:info[@"create_time_geshi"]].width+10, 40)];
    time.font = kFont;
    time.text = info[@"create_time_geshi"];
    time.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self.scrollView addSubview:time];
    //考试时间
    UIImageView *timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, userName.frame.origin.y+userName.frame.size.height+20, 24, 24)];
    timeImageView.image = [UIImage imageNamed:@"ic_access_time"];
    [self.scrollView addSubview:timeImageView];
    float kaoshiLabelW = [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:info[@"exam_time"]].width;
    UILabel *kaoshiLabel = [[UILabel alloc] initWithFrame:CGRectMake(47, timeImageView.frame.origin.y, kaoshiLabelW+70, 24)];
    kaoshiLabel.font = kFont;
    kaoshiLabel.text = [NSString stringWithFormat:@"考试时间：%@",info[@"exam_time"]];
    [self.scrollView addSubview:kaoshiLabel];
    //考试地点
    UIImageView *didianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(timeImageView.frame.origin.x, timeImageView.frame.origin.y+timeImageView.frame.size.height+10, 24, 24)];
    didianImageView.image = [UIImage imageNamed:@"icon_position"];
    [self.scrollView addSubview:didianImageView];
    float didianLabelW = [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:info[@"school_name"]].width+70;
    UILabel *didianLabel = [[UILabel alloc] initWithFrame:CGRectMake(kaoshiLabel.frame.origin.x, didianImageView.frame.origin.y, didianLabelW, 24)];
    didianLabel.font = kFont;
    didianLabel.text = [NSString stringWithFormat:@"考试地点：%@",info[@"school_name"]];
    [self.scrollView addSubview:didianLabel];
    //Part1栏目
    UILabel *part1Label = [[UILabel alloc] initWithFrame:CGRectMake(didianLabel.frame.origin.x,didianLabel.frame.origin.y+didianLabel.frame.size.height+10,  40, 35)];
    part1Label.font = kFont;
    part1Label.text = @"Part1";
    [self.scrollView addSubview:part1Label];
    float part1BtnW = [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:info[@"p1name"]].width;
    if(part1BtnW > (kWidth-(part1Label.frame.origin.x+part1Label.frame.size.width+10))){
        part1BtnW = (kWidth-(part1Label.frame.origin.x+part1Label.frame.size.width+10));
    }
    UIButton *part1Btn = [[UIButton alloc] initWithFrame:CGRectMake(part1Label.frame.origin.x+part1Label.frame.size.width+5, part1Label.frame.origin.y, part1BtnW+20, 35)];
    [part1Btn setTitle:info[@"p1name"] forState:UIControlStateNormal];
    part1Btn.font = kFont;
    [part1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [part1Btn.layer setMasksToBounds:YES];
    [part1Btn.layer setCornerRadius:18.0];
    [part1Btn.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [part1Btn.layer setBorderColor:CGColorCreate(colorSpace, (CGFloat[]){240/255.0,240/255.0,240/255.0,240/255.0})];
    [self.scrollView addSubview:part1Btn];
    //Part2栏目
    
    UILabel *part2Label = [[UILabel alloc] initWithFrame:CGRectMake(part1Label.frame.origin.x, part1Label.frame.origin.y+part1Label.frame.size.height+10, 40, 35)];
    part2Label.font = kFont;
    part2Label.text = @"Part2";
    [self.scrollView addSubview:part2Label];
    float part2BtnW = [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:info[@"p2name"]].width;
    if(part2BtnW > (kWidth-(part2Label.frame.origin.x+part2Label.frame.size.width+10))){
        part2BtnW = (kWidth-(part2Label.frame.origin.x+part2Label.frame.size.width+10));
    }
    UIButton *part2Btn = [[UIButton alloc] initWithFrame:CGRectMake(part2Label.frame.origin.x+part2Label.frame.size.width+5, part2Label.frame.origin.y, part2BtnW, 35)];
    [part2Btn setTitle:info[@"p2name"] forState:UIControlStateNormal];
    [part2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    part2Btn.font = kFont;
    [part2Btn.layer setMasksToBounds:YES];
    [part2Btn.layer setCornerRadius:18.0];
    [part2Btn.layer setBorderWidth:1.0];
    [part2Btn.layer setBorderColor:CGColorCreate(colorSpace, (CGFloat[]){240/255.0,240/255.0,240/255.0,240/255.0})];
    [self.scrollView addSubview:part2Btn];
    //帖子内容
    float contentLabelH = [self boundingRectWithSize:CGSizeMake(kWidth, 0) string:info[@"content"]].height;
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, part2Btn.frame.origin.y+part2Btn.frame.size.height+10, kWidth-10, contentLabelH)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = kFont;
    contentLabel.text = info[@"content"];
    [self.scrollView addSubview:contentLabel];
    //图片
    int imgY = contentLabel.frame.origin.y+contentLabel.frame.size.height+10;
    //float imgViewH = 0.0;
    //UIView *imgView = [[UIView alloc] init];
    if([info[@"images"] count]>=1){
    for(int i=0; i<[info[@"images"] count];i++){
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:info[@"images"][i][@"middle_image"]]];
        [imageView setFrame:CGRectMake(5, imgY, imageView.image.size.width, imageView.image.size.height)];
        [self.scrollView addSubview:imageView];
        imgY += imageView.image.size.height+5;
        i++;
    }
    }
    self.scrollView.contentSize = CGSizeMake(0, imgY);
    
}
@end
