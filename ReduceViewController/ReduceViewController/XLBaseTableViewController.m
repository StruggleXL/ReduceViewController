//
//  XLBaseTableViewController.m
//  ReduceViewController
//
//  Created by xl on 17/1/5.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "XLBaseTableViewController.h"

@interface XLBaseTableViewController ()

@end

@implementation XLBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBaseDataSource];
    [self setupBaseDelegate];
}

- (void)setupBaseDataSource {
    self.baseDataSource = [[XLBaseDataSource alloc]initWithModelForCellClass:^Class(id model) {
        if ([self respondsToSelector:@selector(tableViewCellWithModel:)]) {
            Class aClass = [self tableViewCellWithModel:model];
            if (aClass) {
                return aClass;
            }
        }
        return [UITableViewCell class];
    }];
}
- (void)setupBaseDelegate {
    self.baseDelegate = [[XLTableDelegate alloc]init];
    self.baseDelegate.viewController = self;
}
#pragma mark - setter 
- (void)setBaseDataSource:(XLBaseDataSource *)baseDataSource {
    _baseDataSource = baseDataSource;
    self.tableView.dataSource = baseDataSource;
}
- (void)setBaseDelegate:(XLTableDelegate *)baseDelegate {
    _baseDelegate = baseDelegate;
    self.tableView.delegate = baseDelegate;
}
@end
