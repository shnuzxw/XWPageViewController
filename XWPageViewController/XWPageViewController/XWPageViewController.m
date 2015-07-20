//
//  XWPageViewController.m
//  UIPageViewController
//
//  Created by Zhang Xiaowei on 15/7/10.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//
#import "XWPageViewController.h"
@interface XWPageViewController()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) UISegmentedControl *segment; // 分段控制器
@property (nonatomic, strong) NSArray *titles;  // UISegment的Title数组
@property (nonatomic, strong) NSArray <XWPageViewControllerDelegate>*viewControllers; // 视图控制器数组

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIViewController <XWPageViewControllerDelegate>*nextViewController; // 应显示的下一个试图控制
@property (nonatomic, assign) NSInteger nextPage; // 应该显示的下一页索引
@property (nonatomic, strong) UIView *segmentDefaultView; // UISegmentedControl的默认载体
@property (nonatomic, assign) NSInteger segmentDefaultIndex; // 默认索引，即默认显示第几个页面，当前页面及其索引都会随之改变

@property (nonatomic, assign) BOOL naviAnpi;
@end

@implementation XWPageViewController

// 复写方法
#pragma mark - Overwrite Methods
- (instancetype)init{
    self = [super init];
    if (self) {
        _nextPage = -1;
        _segmentShowType = XWPageVCSegmentShowTypeTitleView;
        _isShowPageIndicator = NO;
        _segmentCenter = CGPointMake(XWScreenWidth / 2.0, 22);
        _segmentDefaultIndex = 0;
    }
    return self;
}

- (instancetype)initWithViewControllers:(NSArray <XWPageViewControllerDelegate>*)viewControllers
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

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self pageViewController];
    
    [self configUISegmentedControl];
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

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
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

// Delegate may specify a different spine location for after the interface orientation change. Only sent for transition style 'UIPageViewControllerTransitionStylePageCurl'.
// Delegate may set new view controllers or update double-sided state within this method's implementation as well.
//- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
//    
//}
//
//- (NSUInteger)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0){
//    
//}
//- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0){
//    
//}

#pragma mark  UIPageViewControllerDataSource
/**** @required ****/

// In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
// Return 'nil' to indicate that no more progress can be made in the given direction.
// For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.

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
- (void)configNavigationControllerView{
    [self.navigationController.view addSubview:self.segment];
}

- (void)configUISegmentedControl{
    switch (_segmentShowType) {
        case XWPageVCSegmentShowTypeTitleView:
        {
            self.segment.center = self.navigationItem.titleView.center;
            self.navigationItem.titleView = self.segment;
        }
            break;
        case XWPageVCSegmentShowTypeNavigationView:
        {
            self.segment.center = _segmentCenter;
            if (_segmentView) {
                [_segmentView addSubview:self.segment];
                [self.navigationController.view addSubview:_segmentView];
            }else{
                [self.segmentDefaultView addSubview:self.segment];
                [self.navigationController.view addSubview:self.segmentDefaultView];
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

/* 数据 */
#pragma mark - ----- Data -----
#pragma mark -

//数据请求
#pragma mark Request Data

// 处理数据
#pragma mark Handle Data

/* 事件 */
#pragma mark - ----- Events -----
#pragma mark -

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

// Push Present
#pragma mark - Push Present
#pragma mark -

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
        CGRect frame = self.view.bounds;
        CGFloat y = 0;
        BOOL isAlpha = self.navigationController.navigationBar.translucent;
        if (self.segmentShowType == XWPageVCSegmentShowTypeNavigationView) {
            if (self.segmentView) {
                y = 20 + ((!isAlpha) ? 44 : 0);
            }
        }
        _pageViewController.view.frame = CGRectMake(0, y, CGRectGetWidth(frame), CGRectGetHeight(frame));
        
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
        
        for (UIViewController <XWPageViewControllerDelegate>*controller in self.viewControllers) {
            [controller xwPageViewController:self showFrame:frame];
        }
    }
    return _pageViewController;
}
                               
- (UIView *)segmentDefaultView{
    if (!_segmentDefaultView) {
        _segmentDefaultView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, XWScreenWidth, 44.0)];
        UIColor *color = _segmentDefaultViewBackGroundColor ? _segmentDefaultViewBackGroundColor : [UIColor whiteColor];
        _segmentDefaultView.backgroundColor = color;
    }
    return _segmentDefaultView;
}

// Set方法
#pragma mark - Setter
- (void)setSegmentCenter:(CGPoint)segmentCenter{
    self.segment.center = segmentCenter;
}

- (void)setSegmentTintColor:(UIColor *)segmentTintColor{
    self.segment.tintColor = segmentTintColor;
}

@end
