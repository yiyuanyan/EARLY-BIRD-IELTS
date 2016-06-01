//
//  exercisesViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/5/26.
//  Copyright © 2016年 何建新. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kFont [UIFont fontWithName:@"Arial" size:14]
#import "exercisesViewController.h"
#import "AFNetworking.h"
#import "exercisesTableViewCell.h"


@interface exercisesViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong) NSMutableDictionary *infoDic;  //JSON返回的数据
@property(nonatomic, strong) NSMutableDictionary *infoDic2;  //JSON返回的数据
@property(nonatomic, assign)int currentPage;  //ScrollView当前页面
@end

@implementation exercisesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    //去掉导航栏背景色和导航栏边框
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //今日联系和我已掌握按钮
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 40)];
    //topView.backgroundColor = [UIColor redColor];
    //今日练习
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kWidth/2, 40)];
    [btn1 setTitle:@"今日练习" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
    btn1.tag = 1;
    //[btn1 addTarget:self action:@selector(createTableView:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn1];
    //我已掌握
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(kWidth/2, 0, kWidth/2, 40)];
    [btn2 setTitle:@"我已掌握" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
    btn2.tag = 2;
    [topView addSubview:btn2];
    //scrollView,装在两个tableView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, kWidth*2, kHeight-104)];
    //设置scrollView的size
    self.scrollView.contentSize = CGSizeMake(kWidth*3, 0);
    //设置scrollView的滚动
    self.scrollView.pagingEnabled = YES;
    //隐藏滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    //[self createTableView:1];
    //
    [self getNetworkingJSON:@"http://testapp.benniaoyasi.com/api.php?m=api&c=neveryday&a=index&appid=1&devtype=ios&version=1.0.1&device=iphone5s&mobile=18600562546" num:1];
    [self getNetworkingJSON:@"http://testapp.benniaoyasi.com/api.php?m=api&c=Neveryday&a=grasp&appid=1&devtype=ios&version=1.0.1&device=iphone5s&mobile=18600562546" num:2];
    
    [self.view addSubview:topView];
    [self.view addSubview:self.scrollView];
    
    
    
    
}
-(void)createTableView:(int)num{
    CGFloat x = 0;
    if(num == 1){
        x = 0;
    }else if(num == 2){
        x = kWidth;
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, 0, kWidth, kHeight-104) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 100 + num;
    [self.scrollView addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//获取网络数据
-(void)getNetworkingJSON:(NSString *)url num:(int)num{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"ecode"] isEqualToString:@"0"]){
            if(num == 1){
                self.infoDic = responseObject[@"edata"];
            }else if(num == 2){
                self.infoDic2 = responseObject[@"edata"];
            }
            
            //NSLog(@"%@",self.infoDic);
            [self createTableView:num];
            //获取数据刷新内容
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoDic.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    exercisesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[exercisesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    if(tableView.tag == 101){
        if(indexPath.section == 0){
            cell.infoDic = self.infoDic[@"part1"][indexPath.row];
        }else if(indexPath.section == 1){
            cell.infoDic = self.infoDic[@"part2_3"][indexPath.row];
        }
    }else if(tableView.tag == 102){
        if(indexPath.section == 0){
            cell.infoDic = self.infoDic2[@"part1"][indexPath.row];
        }else if(indexPath.section == 1){
            cell.infoDic = self.infoDic2[@"part2_3"][indexPath.row];
        }
    }
    
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    customView.backgroundColor = [UIColor whiteColor];
    NSString *str = @"";
    if(section == 0){
        str = @"PART1";
    }else{
        str = @"PART2&3";
    }
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    titleLabel.text = str;
    titleLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [customView addSubview:titleLabel];
    return customView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark ----scrollView代理方法
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //获取当前页码
    self.currentPage = (targetContentOffset->x) / self.view.frame.size.width + 1;
    NSLog(@"当前第%d页",self.currentPage);
}
@end
