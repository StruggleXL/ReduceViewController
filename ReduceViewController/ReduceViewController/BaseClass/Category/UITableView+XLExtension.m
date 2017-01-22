//
//  UITableView+XLExtension.m
//  ReduceViewController
//
//  Created by xl on 16/9/23.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "UITableView+XLExtension.h"
#import <objc/message.h>
#import "XLTableDelegate.h"
#import "MJRefresh.h"

static const void *xl_tableview_reusableCell_key = "xl_tableview_xl_reusableCell_key";
static const void *xl_tableview_hasRegisterCell_key = "xl_tableview_xl_hasRegisterCell_key";

static const void *xl_tableview_showPullDownRefresh_key = "xl_tableview_showPullDownRefresh_key";

static const void *xl_tableview_showPullUpRefreshMore_key = "xl_tableview_showPullUpRefreshMore_key";

@implementation UITableView (XLExtension)

- (NSMutableDictionary *)xl_reusableCell {
    NSMutableDictionary *cells = objc_getAssociatedObject(self, xl_tableview_reusableCell_key);
    
    if (cells == nil) {
        cells = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self,
                                 xl_tableview_reusableCell_key,
                                 cells,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    
    return cells;
}
- (NSMutableDictionary *)xl_hasRegisterCell {
    NSMutableDictionary *cells = objc_getAssociatedObject(self, xl_tableview_hasRegisterCell_key);
    
    if (cells == nil) {
        cells = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self,
                                 xl_tableview_hasRegisterCell_key,
                                 cells,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    
    return cells;
}

#pragma mark - 下拉、上拉开关
- (void)setShowPullDownRefresh:(BOOL)showPullDownRefresh {
    NSNumber *show = objc_getAssociatedObject(self, xl_tableview_showPullDownRefresh_key);
    if ([show boolValue] == showPullDownRefresh) {
        return;
    }
    objc_setAssociatedObject(self,
                             xl_tableview_showPullDownRefresh_key,
                             @(showPullDownRefresh),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    __weak typeof(self) weakSelf = self;
    if (showPullDownRefresh) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            XLTableDelegate *xlDelegate = (XLTableDelegate *)weakSelf.delegate;
            if ([xlDelegate respondsToSelector:@selector(pullDownToRefreshAction)]) {
                [xlDelegate pullDownToRefreshAction];
            }
        }];
        
    } else {
        self.mj_header.hidden = YES;
    }
}
- (BOOL)showPullDownRefresh {
    NSNumber *show = objc_getAssociatedObject(self, xl_tableview_showPullDownRefresh_key);
    if (!show) {
        return NO;
    }
    return [show boolValue];
}
- (void)setShowPullUpRefreshMore:(BOOL)showPullUpRefreshMore {
    NSNumber *show = objc_getAssociatedObject(self, xl_tableview_showPullUpRefreshMore_key);
    if ([show boolValue] == showPullUpRefreshMore) {
        return;
    }
    objc_setAssociatedObject(self,
                             xl_tableview_showPullUpRefreshMore_key,
                             @(showPullUpRefreshMore),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    __weak typeof(self) weakSelf = self;
    if (showPullUpRefreshMore) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            XLTableDelegate *xlDelegate = (XLTableDelegate *)weakSelf.delegate;
            if ([xlDelegate respondsToSelector:@selector(pullUpToRefreshMoreAction)]) {
                [xlDelegate pullUpToRefreshMoreAction];
            }
        }];
        
    } else {
        self.mj_footer.hidden = YES;
    }
}
- (BOOL)showPullUpRefreshMore {
    NSNumber *show = objc_getAssociatedObject(self, xl_tableview_showPullUpRefreshMore_key);
    if (!show) {
        return NO;
    }
    return [show boolValue];
}

/** 自动下拉一次*/
- (void)beginRefreshing {
    [self.mj_header beginRefreshing];
}
- (void)stopRefreshAnimation {
    [self.mj_footer resetNoMoreData];
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

/** 数据全部加载完成，改变上拉状态*/
- (void)stopRefreshWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}
@end
