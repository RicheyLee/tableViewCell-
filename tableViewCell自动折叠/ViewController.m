//
//  ViewController.m
//  tableViewCell自动折叠
//
//  Created by Qingyun on 15/5/31.
//  Copyright (c) 2015年 HY. All rights reserved.
//

#import "ViewController.h"
#import "tableViewHeaderView.h"


@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *sectionCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 取出XIB文件，注册
    [self.tableView registerNib:[UINib nibWithNibName:@"henderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"headerViewID"];
    // 初始化数组
    self.sectionCount = [NSMutableArray arrayWithArray:@[@1,@1,@1,@1,@1,]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tableView delegate
// section个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionCount.count;
}
// cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 根据BOOL值判断cell的个数
    BOOL show = [self.sectionCount[section] boolValue];
    if (show) {
        return self.sectionCount.count;
    } else {
        return 0;
    }
}

// 绑定cell内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld, %ld", indexPath.section,indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    tableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerViewID"];
    [headerView.headerBt setTitle:[NSString stringWithFormat:@"%ld",section] forState:UIControlStateNormal];
    // 给button设置tag值
    [headerView.headerBt setTag:section];
    [headerView.headerBt addTarget:self action:@selector(changeCellCount:) forControlEvents:UIControlEventTouchDown];
    
    return headerView;
}

-(void)changeCellCount:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
    BOOL show = [self.sectionCount[sender.tag] boolValue];
  
    // 点击headerView，改变BOOL值，返回不同个数的cell
    [self.sectionCount replaceObjectAtIndex:[sender tag] withObject:[NSNumber numberWithBool:!show]];
    // 刷新选中的section
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[sender tag]] withRowAnimation:UITableViewRowAnimationTop];
}


@end
