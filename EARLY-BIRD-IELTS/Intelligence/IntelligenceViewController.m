//
//  IntelligenceViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/6/7.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IntelligenceViewController.h"
#import "IntelligenceTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@interface IntelligenceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UIScrollView *topScrollView;
@property(nonatomic, strong) UIScrollView *shoolScrollView;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *info;
@end

@implementation IntelligenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.shoolScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, [UIScreen mainScreen].bounds.size.height*2)];
    
    
    self.shoolScrollView.showsVerticalScrollIndicator = NO;
    self.shoolScrollView.showsHorizontalScrollIndicator = NO;
    self.shoolScrollView.delegate = self;
    self.shoolScrollView.tag = 200;
    
    
    
    [self createTopScrollView];
    [self createRecommend];
    [self getNetWorkingJSON:@"http://testapp.benniaoyasi.com/api.php?m=api&c=Nbbs&a=listBbs&appid=1&school_id=1&devtype=ios&version=1.0.1&device=iphone5s&mobile=18610905643&uuid=01775B6A-D165-4CBE-8690-7FDA7DE875FE"];
    
    
    [self.view addSubview:self.shoolScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma --mark  自定义方法
-(void)getNetWorkingJSON:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"ecode"] isEqualToString:@"0"]){
            self.info = responseObject[@"edata"];
            [self createTableView];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)goBack{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createTableView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 220, kWidth, [UIScreen mainScreen].bounds.size.height+40)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, view.frame.size.height-100) style:UITableViewStylePlain];
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.bounces = NO;
//    [view addSubview:btn];
//    [view addSubview:label1];
    [view addSubview:self.tableView];
    
    //[self.shoolScrollView setFrame:CGRectMake(0, view.frame.origin.y, kWidth, view.frame.size.height)];
    self.shoolScrollView.contentSize = CGSizeMake(0, [UIScreen mainScreen].bounds.size.height * 2 + 230);
    [self.shoolScrollView addSubview:view];
    
    
    

}
//常见顶部scrollView
-(void)createTopScrollView{
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, kWidth, 120)];
    UIView *top1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 120)];
    top1.backgroundColor = [UIColor redColor];
    UIView *top2 = [[UIView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, 120)];
    top2.backgroundColor = [UIColor blueColor];
    UIView *top3 = [[UIView alloc] initWithFrame:CGRectMake(kWidth *2, 0, kWidth, 120)];
    top3.backgroundColor = [UIColor brownColor];
    self.topScrollView.contentSize = CGSizeMake(kWidth*3, 0);
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    [self.topScrollView addSubview:top1];
    [self.topScrollView addSubview:top2];
    [self.topScrollView addSubview:top3];
    [self.shoolScrollView addSubview:self.topScrollView];
}
//创建推荐课程
-(void)createRecommend{
    UIView *recView = [[UIView alloc] initWithFrame:CGRectMake(0, 56, kWidth, 163)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 60)];
    label1.text = @"推荐课程";
    label1.font = [UIFont fontWithName:@"Arial" size:16];
    label1.textAlignment = NSTextAlignmentCenter;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-60, 10, 50, 40)];
    [btn setTitle:@"全部" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.font = [UIFont fontWithName:@"Arial" size:14];
    [recView addSubview:label1];
    [recView addSubview:btn];
    UIScrollView *recScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 60, kWidth-10, 100)];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view1.backgroundColor = [UIColor brownColor];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(105, 0, 100, 100)];
    view2.backgroundColor = [UIColor brownColor];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(210, 0, 100, 100)];
    view3.backgroundColor = [UIColor brownColor];
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(315, 0, 100, 100)];
    view4.backgroundColor = [UIColor brownColor];
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(630, 0, 100, 100)];
    view5.backgroundColor = [UIColor brownColor];
    [recScrollView addSubview:view1];
    [recScrollView addSubview:view2];
    [recScrollView addSubview:view3];
    [recScrollView addSubview:view4];
    [recScrollView addSubview:view5];
    recScrollView.contentSize = CGSizeMake(630, 0);
    recScrollView.pagingEnabled = YES;
    recScrollView.showsVerticalScrollIndicator = NO;
    recScrollView.showsHorizontalScrollIndicator = NO;
    
    [recView addSubview:recScrollView];
    [self.shoolScrollView addSubview:recView];
}
#pragma mark --tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 60)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWidth-80, 60)];
    label1.font = [UIFont fontWithName:@"Arial" size:16];
    label1.text = @"为您推荐:北京语言大学";
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-60, 10, 50, 40)];
    [btn setTitle:@"全部" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.font = [UIFont fontWithName:@"Arial" size:14];
    [view addSubview:label1];
    [view addSubview:btn];
    return view;
}
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     IntelligenceTableViewCell *cell = [[IntelligenceTableViewCell alloc] init];
     cell.info = self.info[indexPath.row];
     tableView.separatorStyle = UITableViewCellSelectionStyleNone;
     if(indexPath.row % 2 == 0){
         cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
     }
     return cell;
 }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getCellHeight:self.info[indexPath.row]];
    
}
-(NSInteger)getCellHeight:(NSMutableDictionary *)info{
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
    
    int imageCount = (int)[info[@"images"] count];
    float y = contentLabel.frame.origin.y+contentLabel.frame.size.height;
    int cellHeight = y;
    if(imageCount == 1){
        //一张图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, y+5, kWidth/3 * 2, 230)];
        [imageView sd_setImageWithURL:info[@"images"][0][@"middle_image"]];
        
        cellHeight = cellHeight+240;
    }else if(imageCount > 1 && imageCount < 4){
        //2~3张图片
        for(int i=1;i<=imageCount;i++){
            int j = i-1;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(100*j)+(5*j), y+5, 100, 100)];
            [imageView sd_setImageWithURL:info[@"images"][j][@"middle_image"]];
            
        }
        cellHeight += (kWidth-15)/3 + 10;
    }else if(imageCount > 3 && imageCount < 7){
        //4~6张图片
        for(int i=1;i<=imageCount;i++){
            int j = i-1;
            int a = 0;
            if(i<=3){
                a = y+5;
            }else if(i>3 && i<=6){
                j = i - 4;
                a = y+5+100+5;
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(100*j)+(5*j), a, 100, 100)];
            [imageView sd_setImageWithURL:info[@"images"][j][@"middle_image"]];
            
        }
        cellHeight += ((kWidth-15)/3)*2+15;
    }
   // NSLog(@"%d",cellHeight);
    
    
    return cellHeight;
}
//计算文本SIZE
-(CGSize)getStringSize:(NSString *)string{
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:14]} context:nil].size;
    return strSize;
}
#pragma mark --scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.tag == 200){
        if(self.shoolScrollView.contentOffset.y >= 220){
            self.tableView.scrollEnabled = YES;
        }else{
            self.tableView.scrollEnabled = NO;
        }
    }
}
@end
