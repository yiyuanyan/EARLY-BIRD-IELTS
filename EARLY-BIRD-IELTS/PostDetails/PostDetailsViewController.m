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
#define kWidth [UIScreen mainScreen].bounds.size.width
@interface PostDetailsViewController ()

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 40)];
    topView.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    
    
    //
    [self.view addSubview:topView];
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
-(void)getNetWorkingJSON:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
