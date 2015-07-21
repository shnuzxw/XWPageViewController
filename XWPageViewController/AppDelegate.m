//
//  AppDelegate.m
//  UIPageViewController
//
//  Created by Zhang Xiaowei on 15/7/10.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import "AppDelegate.h"
#import "XWPageViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    FirstViewController *fVC = [[FirstViewController alloc] init];
    SecondViewController *sVC = [[SecondViewController alloc] init];
    ThirdViewController *tVC = [[ThirdViewController alloc] init];
    NSArray *viewControllers = @[fVC,sVC,tVC]; // 视图控制器数组
    NSArray *titles = @[@"第一段",@"第二段",@"第三段"]; // 标题数组
    XWPageViewController *pageVC = [[XWPageViewController alloc] initWithViewControllers:viewControllers
                                                                                  titles:titles
                                                                     isShowPageIndicator:NO
                                                                         segmentShowType:XWPageVCSegmentShowTypeNavigationView
                                                                                 toIndex:0];
    pageVC.title = @"张校玮"; // title标题
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, XWScreenWidth, 44)]; // segment的父视图
    view.backgroundColor = [UIColor yellowColor]; // 背景
    pageVC.segmentCenter = CGPointMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0); // 中心点坐标
    pageVC.segmentView = view; // 指定segment的父视图
    pageVC.segmentTintColor = [UIColor redColor]; // 设置segment的tintColor
    [pageVC setWidth:200 forSegmentAtIndex:0]; // 设置segment的宽度
    
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:pageVC];
    self.window.rootViewController = navi;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
