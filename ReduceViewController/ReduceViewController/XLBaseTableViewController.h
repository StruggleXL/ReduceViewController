//
//  XLBaseTableViewController.h
//  ReduceViewController
//
//  Created by xl on 17/1/5.
//  Copyright © 2017年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLBaseDataSource.h"
#import "XLTableDelegate.h"

@protocol XLBaseTableViewControllerProtocol <NSObject>

@optional;
- (Class)tableViewCellWithModel:(id)model;

/** 当cell需要回调方法到vc时，在此方法中实现*/
- (void)handleCallbackOperationWithCell:(__kindof UITableViewCell *)cell model:(id)model;
@end

@interface XLBaseTableViewController : UITableViewController<XLBaseTableViewControllerProtocol,XLTableViewDelegate>

@property (nonatomic,strong) XLBaseDataSource *baseDataSource;
@property (nonatomic,strong) XLTableDelegate *baseDelegate;
@end
