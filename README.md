# XWPageViewController
分页视图控制器，类似AppStore分类的导航栏效果。多种自定义效果。
传入的视图控制器需要实现XWPageViewControllerDelegate，以便于XWPageViewController在显示ViewController时对其Frame进行动态设置，以保证页面UI正常显示，不超过可见范围。

```
FirstViewController *fVC = [[FirstViewController alloc] init];
SecondViewController *sVC = [[SecondViewController alloc] init];
ThirdViewController *tVC = [[ThirdViewController alloc] init];
NSArray *viewControllers = @[fVC,sVC,tVC]; // 视图控制器数组
NSArray *titles = @[@"第一段",@"第二段",@"第三段"]; // 标题数组
XWPageViewController *pageVC = [[XWPageViewController alloc] initWithViewControllers:viewControllers titles:titles isShowPageIndicator:NO segmentShowType:XWPageVCSegmentShowTypeNavigationView toIndex:0];
pageVC.title = @"XWPageViewController"; // title标题
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, XWScreenWidth, 44)]; // segment的父视图
//    view.backgroundColor = [UIColor yellowColor]; // 背景
//    pageVC.segmentCenter = CGPointMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0); // 中心点坐标
//    pageVC.segmentView = view; // 指定segment的父视图
pageVC.segmentTintColor = [UIColor redColor]; // 设置segment的tintColor
[pageVC setWidth:80 forSegmentAtIndex:0]; // 设置segment的宽度
[self.navigationController pushViewController:pageVC animated:YES];
```


