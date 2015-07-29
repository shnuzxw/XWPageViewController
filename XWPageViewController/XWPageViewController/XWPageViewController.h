//
//  XWPageViewController.h
//  UIPageViewController
//
//  Created by Zhang Xiaowei on 15/7/10.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

/**==========================================================
 *  Version: 0.0.1
 *  Description: 解决多视图控制器之间在同一个父视图控制器中切换的问题。
 *==========================================================*/

/**----------------------------------------------------------
 * 特点：
        1. 提供两种切换方式。可左右前后，点击按钮切换。
        2. 提供两种显示方式。可在导航栏的TitleView上显示页面标题，也可在Navigation.view上显示。
        3. 每个模块是一个视图控制器，而非视图。方便管理各个视图，亦可大大降低耦合性。但是，视图控制器需要遵守XWPageViewControllerDelegate协议。
        4. 可自定义UI。
 *----------------------------------------------------------*/

#import <UIKit/UIKit.h>
#define XWScreenWidth [[UIScreen mainScreen] bounds].size.width

// 显示UISegmentedControl的模式
typedef NS_ENUM(NSUInteger, XWPageVCSegmentShowType) {
    XWPageVCSegmentShowTypeTitleView,      // TitleView上，默认值
    XWPageVCSegmentShowTypeNavigationView  // Navigation.view上
};

@class XWPageViewController;

#pragma mark - XWPageViewControllerDelegate
@protocol XWPageViewControllerDelegate <NSObject>
@required
/**
 *  为了良好的适配UI，必须执行该回调方法，重置ViewController.view的元素，保存元素都在可见范围内
 *
 *  @param xwPageViewController 管理ViewController的XWPageViewController的实例
 *  @param frame                相对于ViewController.view的可见Frame
 */
- (void)xwPageViewController:(XWPageViewController *)xwPageViewController visibleFrame:(CGRect)visibleFrame;

@end


#pragma mark - XWPageViewController
@interface XWPageViewController : UIViewController

#pragma mark - Property

@property (nonatomic, assign, readonly) NSInteger        currentIndex;// 当前页面的索引
@property (nonatomic, strong, readonly) UIViewController *currentViewController;// 当前显示的视图控制器

@property (nonatomic, assign) XWPageVCSegmentShowType segmentShowType;// UISegmentedControl显示类型与样式
@property (nonatomic, strong) UIColor                 *segmentTintColor;// UISegmentedControl主题色
/**
 UISegmentedControl的载体与样式
 1. segmentShowType为XWPageVCSegmentShowTypeNavigationView时有效。
 2. 可为空。默认CGRectMake(0,y,ScreenWidth,44)的View。 y根据navigationBar.translucent而定;YES:y = 64;NO:y=0。
 */
@property (nonatomic, strong) UIView *segmentView;



#pragma mark - Function

/**
 *  初始化方法
 *
 *  @param viewControllers     视图控制器数组
 *  @param titles              Segment的Titles数组
 *  @param showType            显示类型：Segment放置的位置
 *
 *  @return XWPageViewController
 */
- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                                 titles:(NSArray *)titles
                        segmentShowType:(XWPageVCSegmentShowType)showType;

/**
 *  初始化方法
 *
 *  @param viewControllers     视图控制器数组
 *  @param titles              Segment的Titles数组
 *  @param showType            显示类型：Segment放置的位置
 *  @param toIndex             默认显示第几页视图控制器
 *
 *  @return XWPageViewController
 */
- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                                 titles:(NSArray *)titles
                        segmentShowType:(XWPageVCSegmentShowType)showType
                                toIndex:(NSUInteger)toIndex;
/**
 *  初始化方法
 *
 *  @param viewControllers     视图控制器数组
 *  @param titles              Segment的Titles数组
 *  @param isShowPageIndicator 是否显示页面指示器
 *  @param showType            显示类型：Segment放置的位置
 *  @param toIndex             默认显示第几页视图控制器
 *
 *  @return XWPageViewController
 */
- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                                 titles:(NSArray *)titles
                    isShowPageIndicator:(BOOL)isShowPageIndicator
                        segmentShowType:(XWPageVCSegmentShowType)showType
                                toIndex:(NSUInteger)toIndex;


- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment; // 设置UISegmentedControl指定index的宽度

@end