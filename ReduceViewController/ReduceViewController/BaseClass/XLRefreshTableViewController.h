//
//  XLRefreshTableViewController.h
//  ReduceViewController
//
//  Created by xl on 17/1/11.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "XLBaseTableViewController.h"
@class NetListMessage;

@protocol XLRefreshTableViewControllerDelegate <NSObject>

- (void)loadDataDidSuccess:(id)resultObject;

@end

@interface XLRefreshTableViewController : XLBaseTableViewController<XLRefreshTableViewControllerDelegate>

@property (nonatomic,strong) NetListMessage *netListMessage;


/**
 自动请求一次数据

 @param animated 是否带下拉动画
 */
- (void)beginLoadDataWithRefreshAnimated:(BOOL)animated;

/** 取消正在进行的请求*/
- (void)cancelLoading;
@end
