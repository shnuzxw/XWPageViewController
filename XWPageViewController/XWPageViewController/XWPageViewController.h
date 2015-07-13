//
//  XWPageViewController.h
//  UIPageViewController
//
//  Created by Zhang Xiaowei on 15/7/10.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XWScreenWidth [[UIScreen mainScreen] bounds].size.width

typedef NS_ENUM(NSUInteger, XWPageVCSegmentShowType) { // 显示UISegmentedControl的模式
    XWPageVCSegmentShowTypeTitleView,      // TitleView上，默认值
    XWPageVCSegmentShowTypeNavigationView  // Navigation.view上
};

@interface XWPageViewController : UIViewController

/**
 当前页面的显示情况
 */
@property (nonatomic, assign, readonly) NSInteger currentIndex;
@property (nonatomic, strong, readonly) UIViewController *currentViewController;

/**
 UISegmentedControl显示类型与样式
 */
@property (nonatomic, assign) XWPageVCSegmentShowType segmentShowType;
@property (nonatomic, assign) CGPoint segmentCenter; // XWPageVCSegmentShowTypeNavigationView时有效
@property (nonatomic, strong) UIColor *segmentTintColor;  // UISegmentedControl主题色

- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment; // 设置UISegmentedControl指定index的宽度

/**
 UISegmentedControl的载体与样式
 1. segmentShowType=XWPageVCSegmentShowTypeNavigationView时有效
 2. 可为空，为空时默认一个View(ScreenWidth,40)
 3. 载体的背景色可以自定义，默认白色
 */
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIColor *segmentDefaultViewBackGroundColor;


@property (nonatomic, assign) BOOL isShowPageIndicator; // 是否显示页面指示器，默认NO



- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                                 titles:(NSArray *)titles
                    isShowPageIndicator:(BOOL)isShowPageIndicator
                        segmentShowType:(XWPageVCSegmentShowType)showType
                                toIndex:(NSUInteger)toIndex;

@end