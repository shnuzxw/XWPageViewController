//
//  RootViewController.m
//  XWPageViewController
//
//  Created by Zhang Xiaowei on 15/7/21.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import "RootViewController.h"
#import "XWPageViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@implementation RootViewController
- (void)click{
    FirstViewController *fVC = [[FirstViewController alloc] init];
    SecondViewController *sVC = [[SecondViewController alloc] init];
    ThirdViewController *tVC = [[ThirdViewController alloc] init];
    NSArray *viewControllers = @[fVC,sVC,tVC]; // 视图控制器数组
    NSArray *titles = @[@"第一段",@"第二段",@"第三段"]; // 标题数组
    XWPageViewController *pageVC = nil;
    pageVC = [[XWPageViewController alloc] initWithViewControllers:viewControllers
                                                            titles:titles
                                               isShowPageIndicator:NO
                                                   segmentShowType:XWPageVCSegmentShowTypeNavigationView
                                                           toIndex:0];
    pageVC.title = @"XWPageViewController"; // title标题
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, XWScreenWidth, 44)]; // segment的父视图
//    view.backgroundColor = [UIColor yellowColor]; // 背景
//    pageVC.segmentCenter = CGPointMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0); // 中心点坐标
//    pageVC.segmentView = view; // 指定segment的父视图
//    pageVC.segmentTintColor = [UIColor redColor]; // 设置segment的tintColor
//    [pageVC setWidth:80 forSegmentAtIndex:0]; // 设置segment的宽度
    [self.navigationController pushViewController:pageVC animated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 300, 44);
    btn.center = self.view.center;
    [btn setTitle:@"XWPageViewController" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

@end
