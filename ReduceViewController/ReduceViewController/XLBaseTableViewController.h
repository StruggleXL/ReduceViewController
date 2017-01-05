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

@end

@interface XLBaseTableViewController : UITableViewController<XLBaseTableViewControllerProtocol,XLTableViewDelegate>

@property (nonatomic,strong) XLBaseDataSource *baseDataSource;
@property (nonatomic,strong) XLTableDelegate *baseDelegate;
@end
