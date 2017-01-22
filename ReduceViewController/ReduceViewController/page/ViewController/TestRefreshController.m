//
//  TestRefreshController.m
//  ReduceViewController
//
//  Created by xl on 17/1/17.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "TestRefreshController.h"
#import "YYModel.h"
#import "NetListMessage.h"
#import "MainRefreshCell.h"
#import "MainRefreshModel.h"

@interface TestRefreshController ()

@end

@implementation TestRefreshController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"3个方法实现上拉、下拉功能";
    
    // 初始化网络请求参数
    [self setupNetworkMsg];
    // 自动请求一次数据，为NO时无下拉刷新动画
    [self beginLoadDataWithRefreshAnimated:YES];
}

/** 初始化网络请求参数*/
- (void)setupNetworkMsg {
    NSDictionary *dic = @{@"method":@"Course.list.course",@"cat_id":@"0"};
    self.netListMessage = [[NetListMessage alloc] init];
    self.netListMessage.params = dic;
    self.netListMessage.httpMethod = AFNetworkPOST;
}
/** 指定cell*/
- (Class)tableViewCellWithModel:(id)model {
    return [MainRefreshCell class];
}
- (void)handleCallbackOperationWithCell:(__kindof UITableViewCell *)cell model:(id)model {
    MainRefreshCell *refreshCell = cell;
    MainRefreshModel *refreshModel = model;
    refreshCell.testBlock = ^(){
        NSLog(@"测试回调===%@",refreshModel.course_name);
    };
}
// 请求成功后的回调
- (void)loadDataDidSuccess:(id)resultObject {
    // 解析，数据处理
    NSArray *items = resultObject[@"page_items"];
    [self.baseDataSource appendRows:[NSArray yy_modelArrayWithClass:[MainRefreshModel class] json:items]];
    [self.tableView reloadData];
}

#pragma mark -tableViewDelegate
/** 若实现此方法，cell的高度为此方法回调的大小，若不实现此方法，则会自动适应高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0f;
}
/** 自定义cell的点击事件回调，若实现此方法，则下面的方法不会回调*/
//- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"简单方法 点击了====%@",((MainRefreshModel *)object).course_name);
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainRefreshModel *model = [self.baseDataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    NSLog(@"点击了===%@",model.course_name);
}
@end
