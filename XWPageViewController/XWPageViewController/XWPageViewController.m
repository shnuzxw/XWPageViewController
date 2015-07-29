//
//  XWPageViewController.m
//  UIPageViewController
//
//  Created by Zhang Xiaowei on 15/7/10.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//
#import "XWPageViewController.h"
@interface XWPageViewController()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UISegmentedControl   *segment;// 分段控制器
@property (nonatomic, strong) NSArray              *titles;// UISegment的Title数组
@property (nonatomic, strong) NSArray              *viewControllers;// 视图控制器数组

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIViewController     *nextViewController;// 应显示的下一个试图控制
@property (nonatomic, assign) NSInteger            nextPage;// 应该显示的下一页索引
@property (nonatomic, strong) UIView               *segmentDefaultView;// UISegmentedControl的默认载体
@property (nonatomic, assign) NSInteger            segmentDefaultIndex;// 默认索引，即默认显示第几个页面，当前页面及其索引都会随之改变

@property (nonatomic, strong) UIView               *priTitleView;// 原始的TitleView
@property (nonatomic, assign) BOOL                 priTranslucent;// 原始的NavigationBar的透明度

@property (nonatomic, assign) BOOL                 isShowPageIndicator;// 是否显示页面指示器，默认NO
@property (nonatomic, strong) UIColor              *segmentDefaultViewBackGroundColor;// 默认当前NavigationBar的barTintColor
@property (nonatomic, assign) CGPoint              segmentCenter;// XWPageVCSegmentShowTypeNavigationView时有效

@end

@implementation XWPageViewController

// 复写方法
#pragma mark - Overwrite Methods
// 初始化方法，初始化变量的默认值
- (instancetype)init{
    self = [super init];
    if (self) {
        _nextPage = -1;
        _segmentShowType = XWPageVCSegmentShowTypeTitleView;
        _isShowPageIndicator = NO;
        _segmentDefaultIndex = 0;
    }
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                                 titles:(NSArray *)titles
                        segmentShowType:(XWPageVCSegmentShowType)showType{
    return [self initWithViewControllers:viewControllers
                                  titles:titles
                     isShowPageIndicator:NO
                         segmentShowType:showType
                                 toIndex:0];
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                                 titles:(NSArray *)titles
                        segmentShowType:(XWPageVCSegmentShowType)showType
                                toIndex:(NSUInteger)toIndex{
    return [self initWithViewControllers:viewControllers
                                  titles:titles
                     isShowPageIndicator:NO
                         segmentShowType:showType
                                 toIndex:0];
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                                 titles:(NSArray *)titles
                    isShowPageIndicator:(BOOL)isShowPageIndicator
                        segmentShowType:(XWPageVCSegmentShowType)showType
                                toIndex:(NSUInteger)toIndex{
    if ([self init]) {
        self.viewControllers = viewControllers;
        self.titles = titles;
        self.isShowPageIndicator = isShowPageIndicator;
        self.segmentShowType = showType;
        if (toIndex < titles.count) {
            self.segmentDefaultIndex = toIndex;
        }
    }
    return self;
}

#pragma mark - OverWrite

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self pageViewController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.priTitleView = self.navigationItem.titleView;
    self.priTranslucent = self.navigationController.navigationBar.translucent;
    
    
    if (!self.segmentView) {
        if (!_segmentDefaultViewBackGroundColor || _segmentDefaultViewBackGroundColor == [UIColor whiteColor]) {
            UIColor *color = self.navigationController.navigationBar.barTintColor;
            if (color) {
                self.segmentDefaultViewBackGroundColor = color;
            }
            self.segmentDefaultView.backgroundColor = self.segmentDefaultViewBackGroundColor;
        }
        self.segmentView = self.segmentDefaultView;
        self.segmentCenter = CGPointMake(CGRectGetWidth(self.segmentView.bounds)/2.0, CGRectGetHeight(self.segmentView.bounds)/2.0);
    }
    
    [self configUISegmentedControlWithIsShow:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self configUISegmentedControlWithIsShow:NO];
    self.navigationItem.titleView = self.priTitleView;
    self.navigationController.navigationBar.translucent = self.priTranslucent;
}

//系统协议
#pragma mark - System Delegate
#pragma mark -

#pragma mark  UIPageViewControllerDelegate
// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers NS_AVAILABLE_IOS(6_0){
    _nextViewController = pendingViewControllers[0];
    _nextPage = [self.viewControllers indexOfObject:_nextViewController];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        _currentViewController = _nextViewController;
        _currentIndex = _nextPage;
        _segment.selectedSegmentIndex = _nextPage;
    }else{
        _nextViewController = nil;
        _nextPage = -1;
    }
}

#pragma mark  UIPageViewControllerDataSource
/**** @required ****/

// 上一个视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return self.viewControllers[index - 1];
}
// 下一个视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == self.viewControllers.count - 1) {
        return nil;
    }
    return self.viewControllers[index + 1];
}

/**** @optional ****/
/* 返回页面指示器数量，0表示隐藏页面指示器 */
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
    return _isShowPageIndicator ? self.viewControllers.count : 0;
}
/* 返回当前页面的索引，页面指示器中标识当前页面的index */
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
    return _isShowPageIndicator ? self.currentIndex : 0;
}

//自定义协议
#pragma mark - Custom Delegate

//自定义方法
#pragma mark - Private Methods
-(void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment{
    if (segment < self.segment.numberOfSegments) {
        [self.segment setWidth:width forSegmentAtIndex:segment];
    }
}

/* UI */
#pragma mark - ----- UI -----
#pragma mark -

//UI配置
#pragma mark ConfigureUI
- (void)configUISegmentedControlWithIsShow:(BOOL)isShow{
    switch (_segmentShowType) {
        case XWPageVCSegmentShowTypeTitleView:
        {
            self.segment.center = self.navigationItem.titleView.center;
            if (isShow) {
                self.navigationItem.titleView = self.segment;
            }else{
                self.navigationItem.titleView = _priTitleView;
            }
        }
            break;
        case XWPageVCSegmentShowTypeNavigationView:
        {
            self.segment.center = self.segmentCenter;
            if (_segmentView) {
                if (isShow) {
                    [_segmentView addSubview:self.segment];
                    [self.navigationController.view addSubview:_segmentView];
                }else{
                    [self.segment removeFromSuperview];
                    [_segmentView removeFromSuperview];
                }
            }else{
                if (isShow) {
                    [self.segmentDefaultView addSubview:self.segment];
                    [self.navigationController.view addSubview:self.segmentDefaultView];
                }else{
                    [self.segment removeFromSuperview];
                    [self.segmentDefaultView removeFromSuperview];
                }
            }
        }
            break;
            
        default:
            break;
    }
}

// 更新UI
#pragma mark UpdateUI

// 适配UI
#pragma mark MakeConstraints

//按钮事件
#pragma mark Event Response
#pragma mark -
- (void)segmentClick:(id)sender{
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl * segment = sender;
        NSInteger selectedIndex = segment.selectedSegmentIndex;
        BOOL selectedIndedIsBigger = (selectedIndex - _currentIndex) > 0 ? YES : NO;
        UIPageViewControllerNavigationDirection direction;
        if (selectedIndedIsBigger) {
            direction = UIPageViewControllerNavigationDirectionForward;
        }else{
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        [self.pageViewController setViewControllers:@[self.viewControllers[selectedIndex]]
                                          direction:direction
                                           animated:YES
                                         completion:nil];
        _currentIndex = selectedIndex;
    }
}

// Get方法
#pragma mark - Getter
- (UISegmentedControl *)segment{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:self.titles];
        if (_segmentTintColor) {
            _segment.tintColor = _segmentTintColor;
        }
        _segment.selectedSegmentIndex = self.segmentDefaultIndex;
        [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
        _currentIndex = self.segmentDefaultIndex;
        _currentViewController = self.viewControllers[self.segmentDefaultIndex];
        [_pageViewController setViewControllers:@[_currentViewController]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         if (finished) {
                                             NSLog(@"Finished:YES");
                                         }else{
                                             NSLog(@"Finished:NO");
                                         }
        }];
        _pageViewController.view.frame = self.view.frame;
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
        
        CGFloat moveY = 0.0;
        if (self.segmentShowType == XWPageVCSegmentShowTypeNavigationView) {
            moveY = CGRectGetHeight(self.segmentView.frame);
        }
        
        CGRect frame = _pageViewController.view.frame;
        _pageViewController.view.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + moveY, CGRectGetWidth(frame), CGRectGetHeight(frame) - moveY);
        
        CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
        CGFloat xwPageViewHeight = CGRectGetHeight(self.view.bounds);
        CGFloat navigationViewHeight = CGRectGetHeight(self.navigationController.view.frame);
        CGFloat pageViewHeight = CGRectGetHeight(_pageViewController.view.frame);
        CGFloat segmentViewMinY = CGRectGetMinY(self.segmentView ? self.segmentView.frame : self.segmentDefaultView.frame);
        CGFloat segmentViewMaxY = CGRectGetMaxY(self.segmentView ? self.segmentView.frame : self.segmentDefaultView.frame);
        CGFloat segmentViewHeight = CGRectGetHeight(self.segmentView ? self.segmentView.frame : self.segmentDefaultView.frame);
        NSLog(@"screenHeight:%.1f, xwPageViewHeight:%.1f, navigationViewHeight:%.1f, pageViewHeight:%.1f, segmentViewY:%.1f, segmentViewHeight:%.1f", screenHeight, xwPageViewHeight, navigationViewHeight, pageViewHeight, segmentViewMinY, segmentViewHeight);
        
        if (screenHeight != navigationViewHeight) {
            NSLog(@"屏幕高度不等于导航栏View的高度，不应该出现这种情况,也基本不可能出现这种情况");
        }
        
        if (xwPageViewHeight != pageViewHeight) {
            NSLog(@"XWPageViewController.view的高度不等于XWPageViewController.pageViewController.view的高度，不应该出现，也不可能出现");
        }
        
        CGRect visibleFrame = CGRectMake(0, 0, XWScreenWidth, pageViewHeight);
        if (pageViewHeight == navigationViewHeight) {
            visibleFrame = CGRectMake(0, segmentViewMaxY, XWScreenWidth, pageViewHeight - segmentViewMaxY);
        }else{
            CGFloat beyondScreenHeight = pageViewHeight + segmentViewMaxY - navigationViewHeight;
            visibleFrame = CGRectMake(0, beyondScreenHeight, XWScreenWidth, pageViewHeight - beyondScreenHeight);
        }
        
        for (UIViewController <XWPageViewControllerDelegate>*controller in self.viewControllers) {
            
            [controller xwPageViewController:self visibleFrame:visibleFrame];
        }
    }
    return _pageViewController;
}
                               
- (UIView *)segmentDefaultView{
    if (!_segmentDefaultView) {
        CGFloat y = 0;
        if (self.navigationController && self.navigationController.navigationBar.translucent == YES) {
            y = 64.0;
        }else{
            y = 0.0;
        }
        _segmentDefaultView = [[UIView alloc] initWithFrame:CGRectMake(0, y, XWScreenWidth, 44.0)];
        if (!_segmentDefaultViewBackGroundColor) {
            _segmentDefaultViewBackGroundColor = [UIColor whiteColor];
        }
        _segmentDefaultView.backgroundColor = _segmentDefaultViewBackGroundColor;
    }
    return _segmentDefaultView;
}

// Set方法
#pragma mark - Setter
//- (void)setSegmentTintColor:(UIColor *)segmentTintColor{
//    self.segmentTintColor = segmentTintColor;
//    self.segment.tintColor = self.segmentTintColor;
//}

- (void)setSegmentView:(UIView *)segmentView{
    _segmentView = segmentView;
    CGRect frame = self.segmentView.bounds;
    self.segmentCenter = CGPointMake(CGRectGetWidth(frame)/2.0, CGRectGetHeight(frame)/2.0);
}

@end
