//
//  Part1ViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/6/2.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part1ViewController.h"
#import "AFNetworking.h"
#import "Part1ListTableViewController.h"
#define kFont [UIFont fontWithName:@"Arial" size:14]
#define kWidth [UIScreen mainScreen].bounds.size.width
@interface Part1ViewController ()

@property(nonatomic, strong)NSMutableArray *allTopBtn;
@property(nonatomic, strong)NSMutableDictionary *rsArray;
@end

@implementation Part1ViewController

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidLoad];
    self.allTopBtn = [NSMutableArray array];
    self.rsArray = [NSMutableDictionary dictionary];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.topScrollView.backgroundColor = [UIColor redColor];
    self.tableScrollView.backgroundColor = [UIColor blueColor];
    self.tableScrollView.pagingEnabled = YES;
    self.tableScrollView.showsVerticalScrollIndicator = FALSE;
    self.tableScrollView.showsHorizontalScrollIndicator = FALSE;
    [self getNetWorkingJSON:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=Ncategory&a=listcategory&pid=1&devtype=android&version=2.0" type:@"top" tableViewX:0.0 tableViewTag:0];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createTopView:(NSDictionary *)infoDic{
    
    float btnX = 0.0;
    float allBtnX = 0.0;
    int i=0;
    float tableViewX = -kWidth;
    for (NSDictionary *d in infoDic) {
        tableViewX += kWidth;
        CGSize btnSize = [self getStringSize:d[@"ename"]];
        if(i==0){
            btnX = 10;
        }else{
            btnX = allBtnX+(10*(i+1));
        }
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, -64, btnSize.width, 30)];
        [btn setTitle:d[@"ename"] forState:UIControlStateNormal];
        btn.tag = 200 + i;
        [btn setTitleColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] forState:UIControlStateNormal];
        if(btn.tag == 200){
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        btn.font = kFont;
        [btn addTarget:self action:@selector(clickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        //所有按钮添加到数组中
        [self.allTopBtn addObject:btn];
        [self.topScrollView addSubview:btn];
        //调用网络接口获取table的数据
        
        NSString *url = [NSString stringWithFormat:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=ncategory&a=listcategory&devtype=android&version=2.0&uuid=123&leval=%@",d[@"evalue"]];
        [self getNetWorkingJSON:url type:@"tableView" tableViewX:tableViewX tableViewTag:i];
        allBtnX += btnSize.width;
        
        i++;
    }
    //[self.topScrollView addSubview:btnView];
    //重新设置topScrollView的contentSize
    self.topScrollView.showsHorizontalScrollIndicator = FALSE;
    self.topScrollView.showsVerticalScrollIndicator = FALSE;
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.contentSize = CGSizeMake(allBtnX+150, 0);
}
#pragma mark -- 自定义方法
-(void)clickTopBtn:(id)sender{

}
-(void)createTableView:(NSArray *)infoArray tableViewX:(float)tableViewX tableViewTag:(int)tableViewTag{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, 0, kWidth, [UIScreen mainScreen].bounds.size.height-94) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 100 + tableViewTag;
    //int tableTag = 100 + tableViewTag;
    NSString *str = [NSString stringWithFormat:@"%d",100+tableViewTag];
    //self.rsArray[tableTag] = infoArray;
    //[self.rsArray[str] addObject:infoArray];
    [self.rsArray setObject:infoArray forKey:str];
    [self.tableScrollView addSubview:tableView];
    self.tableScrollView.contentSize = CGSizeMake(kWidth * self.allTopBtn.count, 0);
    [tableView reloadData];
}
-(CGSize)getStringSize:(NSString *)string{
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont} context:nil].size;
    return strSize;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getNetWorkingJSON:(NSString *)url type:(NSString *)type tableViewX:(float)tableViewX tableViewTag:(int)tableViewTag{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"ecode"] isEqualToString:@"0"]){
            if([type isEqualToString:@"top"]){
                [self createTopView:responseObject[@"edata"]];
            }else if([type isEqualToString:@"tableView"]){
                
                [self createTableView:responseObject[@"edata"] tableViewX:tableViewX tableViewTag:tableViewTag];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark --tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *str = [NSString stringWithFormat:@"%ld",(long)tableView.tag];
    return [self.rsArray[str] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = kFont;
    NSString *str = [NSString stringWithFormat:@"%ld",(long)tableView.tag];
    cell.textLabel.text = self.rsArray[str][indexPath.row][@"chinese"];
    tableView.separatorStyle = UITableViewScrollPositionNone;
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    }
    
    
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [NSString stringWithFormat:@"%ld",(long)tableView.tag];
    Part1ListTableViewController *part1 = [[Part1ListTableViewController alloc] init];
    part1.chinese = self.rsArray[str][indexPath.row][@"chinese"];
    part1.english = self.rsArray[str][indexPath.row][@"english"];
    part1.cid = self.rsArray[str][indexPath.row][@"id"];
    part1.title = self.rsArray[str][indexPath.row][@"english"];
    [self.navigationController pushViewController:part1 animated:YES];
}
@end
