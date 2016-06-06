//
//  HomeViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/5/26.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "HomeViewController.h"
#import "exercisesViewController.h"
#import "Part1ViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
    UIButton *exercisesBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 40)];
    [exercisesBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [exercisesBtn setTitle:@"开始学习" forState:UIControlStateNormal];
    [exercisesBtn addTarget:self action:@selector(exercisesView) forControlEvents:UIControlEventTouchUpInside];
    UIButton *part1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 80, 40)];
    [part1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [part1 setTitle:@"Part1" forState:UIControlStateNormal];
    [part1 addTarget:self action:@selector(part1View) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:part1];
    [self.view addSubview:exercisesBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)exercisesView{
    exercisesViewController *exeView = [[exercisesViewController alloc] init];
    //[exeView.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:exeView animated:YES];
}
-(void)part1View{
//    UIStoryboard *part1Storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *part1Controller = [part1Storyboard instantiateViewControllerWithIdentifier:@"part1"];
    Part1ViewController *part1Controller = [[Part1ViewController alloc] initWithNibName:@"Part1View" bundle:nil];
    //[self.navigationController setNavigationBarHidden:NO];
    part1Controller.title = @"PART1";
    [self.navigationController pushViewController:part1Controller animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
