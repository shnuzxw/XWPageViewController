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
[self.navigationController pushViewController:pageVC animated:YES];
```

#示例
##示例1
![示例1](https://github.com/shnuzxw/XWPageViewController/blob/master/XWPageViewController1.gif)
##示例2
![示例2](https://github.com/shnuzxw/XWPageViewController/blob/master/XWPageViewController2.gif)


