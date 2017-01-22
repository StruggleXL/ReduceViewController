//
//  XLRefreshTableViewController.m
//  ReduceViewController
//
//  Created by xl on 17/1/11.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "XLRefreshTableViewController.h"
#import "UITableView+XLExtension.h"
#import "HttpRequestManager.h"
#import "NetListMessage.h"

@interface XLRefreshTableViewController ()

@property (nonatomic,assign) BOOL isRefresh;
@property (nonatomic,strong) NSURLSessionDataTask *xl_task;
@end


#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wprotocol"

@implementation XLRefreshTableViewController
#pragma clang diagnostic pop
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.showPullDownRefresh = YES;
    self.tableView.showPullUpRefreshMore = YES;
    
    // 更新下footer状态，当无数据时，不显示footer
    [self changeRefreshStatus];
}
#pragma mark - 下拉、上拉回调
- (void)pullDownToRefreshAction {
    self.isRefresh = YES;
    [self xl_loadDataWithPage:1];
}

- (void)pullUpToRefreshMoreAction {
    // 加载数据
    self.isRefresh = NO;
    [self xl_loadDataWithPage:self.netListMessage.currentPage];
}
#pragma mark - Public
/**
 请求一次数据
 
 @param animated 是否带下拉动画
 */
- (void)beginLoadDataWithRefreshAnimated:(BOOL)animated {
    if (animated) {
        [self.tableView beginRefreshing];
    } else {
        [self pullDownToRefreshAction];
    }
}
/** 取消请求*/
- (void)cancelLoading {
    [self.xl_task cancel];
}
#pragma mark - Private
/** 根据页数加载数据*/
- (void)xl_loadDataWithPage:(NSInteger)page {
    self.netListMessage.pageSize = 10;
    self.netListMessage.currentPage = page;
    NSMutableDictionary *dic = [self.netListMessage.params mutableCopy];
    NSNumber *lastSize = dic[@"pagesize"];
    NSNumber *lastPage = dic[@"page"];
    if (lastSize) {
        [dic removeObjectForKey:dic[@"pagesize"]];
    }
    if (lastPage) {
        [dic removeObjectForKey:dic[@"page"]];
    }
    [dic setObject:@(self.netListMessage.pageSize) forKey:@"pagesize"];
    [dic setObject:@(self.netListMessage.currentPage) forKey:@"page"];
    self.netListMessage.params = dic;
    //TODO: 这里将返回的NSURLSessionDataTask 赋值给xl_task
    [[HttpRequestManager sharedInstance]sendMessage:self.netListMessage success:^(NSDictionary *resultObject) {
        NSDictionary *pageInfo = resultObject[@"page_info"];
        self.netListMessage.totalPage = [pageInfo[@"pages"] integerValue];
        if (self.isRefresh) {
            [self.baseDataSource clearAllRows];
        }
        [self loadDataDidSuccess:resultObject];
        [self changeRefreshStatus];
        if (self.netListMessage.totalPage >= self.netListMessage.currentPage) {
            ++self.netListMessage.currentPage;
        }
    } fail:^(NSError *error) {
        [self.tableView stopRefreshAnimation];
    }];
}
/** 刷新上拉、下拉控件状态*/
- (void)changeRefreshStatus {
    self.tableView.showPullUpRefreshMore = ([self.baseDataSource rowsCount] > 0);
    if (self.netListMessage.currentPage == self.netListMessage.totalPage) {
        // 数据已经全部加载完
        [self.tableView stopRefreshWithNoMoreData];
    } else {
        // 还没有加载完
        [self.tableView stopRefreshAnimation];
    }
    
}
@end
