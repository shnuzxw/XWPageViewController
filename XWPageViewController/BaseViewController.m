//
//  BaseViewController.m
//  XWPageViewController
//
//  Created by Zhang Xiaowei on 15/7/20.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation BaseViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self tableView];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
}

- (void)xwPageViewController:(XWPageViewController *)xwPageViewController visibleFrame:(CGRect)visibleFrame{
    self.tableView.frame = visibleFrame;
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1234wsfadf"];
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"1234wsfadf"];
        [self.view addSubview:_tableView];
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"123%ld",(long)i]];
        }
    }
    return _dataSource;
}



@end
