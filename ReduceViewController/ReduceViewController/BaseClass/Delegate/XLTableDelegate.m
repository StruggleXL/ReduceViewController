//
//  XLTableDelegate.m
//  ReduceViewController
//
//  Created by xl on 16/9/23.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "XLTableDelegate.h"
#import <objc/runtime.h>
#import "XLBaseDataSource.h"
#import "XLBaseCell.h"
#import "NSObject+CellHeight.h"
#import "UITableView+XLExtension.h"

@implementation XLTableDelegate

#pragma mark - 注册cell
/** 判断cell是否由代码创建*/
- (BOOL)cellCreatByCode:(Class)cellClass {
    unsigned int count;
    Method *methods = class_copyMethodList([cellClass class], &count);
    BOOL flag = NO;
    for (int i=0; i<count; i++) {
        Method aMethod = methods[i];
        if ([@"initWithStyle:reuseIdentifier:" isEqualToString:NSStringFromSelector(method_getName(aMethod))]) {
            flag = YES;
        }
    }
    free(methods);
    return flag;
}
/** 注册cell（同一个cell只会注册一次）*/
- (void)registerCellWithTableView:(UITableView *)tableView cellClass:(Class)cellClass {
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    if (![tableView.xl_hasRegisterCell objectForKey:className]) {
        if (![tableView dequeueReusableCellWithIdentifier:className]) {
            if ([self cellCreatByCode:cellClass]) {
                // 通过代码创建的cell
                [tableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
            } else {
                // 通过xib创建的cell
                [tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
            }
        } else {
            // 通过storyboard创建的cell，不需任何处理
        }
        // 保存已注册标记
        [tableView.xl_hasRegisterCell setObject:@(YES) forKey:className];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLBaseDataSource *dataSource = tableView.dataSource;
    NSObject *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = dataSource.cellClassBlock(object);
    // 注册cell
    [self registerCellWithTableView:tableView cellClass:cellClass];
    if ([self.viewController respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
       return  [self.viewController tableView:tableView heightForRowAtIndexPath:indexPath];
    } else {
        
        if (object.xl_cellHeight <=0) {
            // 缓存cell高度
            object.xl_cellHeight= [cellClass tableView:tableView rowHeightForObject:object];
        }
        return object.xl_cellHeight;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    if ([self.viewController respondsToSelector:@selector(didSelectObject:atIndexPath:)]) {
        XLBaseDataSource *dataSource = tableView.dataSource;
        id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
        [self.viewController performSelector:@selector(didSelectObject:atIndexPath:) withObject:object withObject:indexPath];
    } else {
        if([self.viewController respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.viewController tableView:tableView didSelectRowAtIndexPath:indexPath];
        }

    }
    
}
#pragma mark - 下拉、上拉触发方法
- (void)pullDownToRefreshAction {
    if ([self.viewController respondsToSelector:@selector(pullDownToRefreshAction)]) {
        [self.viewController pullDownToRefreshAction];
    } else {
        
    }
}

- (void)pullUpToRefreshMoreAction {
    if ([self.viewController respondsToSelector:@selector(pullUpToRefreshMoreAction)]) {
        [self.viewController pullUpToRefreshMoreAction];
    } else {
        
    }
}
@end
