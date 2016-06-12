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
    return 100;
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
