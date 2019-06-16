//
//  ViewController.m
//  ReadPDF
//
//  Created by miniso_lj on 2019/6/3.
//  Copyright © 2019年 miniso_lj. All rights reserved.
//

#import "ViewController.h"
#import "Macro.h"
#import "ReadPDFViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"readPDF";
    
    _dataArray = @[@"本地",@"网络"];
    
    [self createTableView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBarAndStatusBar, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - Height_NavBarAndStatusBar) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.backgroundColor = RGBCOLOR(238, 238, 238);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadPDFViewController *vc = [[ReadPDFViewController alloc] init];
    vc.type = indexPath.row;
    [self.navigationController pushViewController:vc animated:NO];
}

@end
