//
//  UITableView+XLExtension.h
//  ReduceViewController
//
//  Created by xl on 16/9/23.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (XLExtension)

/** 存放 专门用来计算cellHeight的唯一cell*/
@property (nonatomic, strong, readonly) NSMutableDictionary *xl_reusableCell;

/** 存放 是否需要注册cell（cell只注册一次即可）*/
@property (nonatomic, strong, readonly) NSMutableDictionary *xl_hasRegisterCell;

/** 是否显示下拉刷新*/
@property (nonatomic, assign) BOOL showPullDownRefresh;
/** 是否显示上拉加载*/
@property (nonatomic, assign) BOOL showPullUpRefreshMore;

/** 自动下拉一次*/
- (void)beginRefreshing;

/** 停止上拉、下拉动画*/
- (void)stopRefreshAnimation;

/** 数据全部加载完成，改变上拉状态*/
- (void)stopRefreshWithNoMoreData;
@end
