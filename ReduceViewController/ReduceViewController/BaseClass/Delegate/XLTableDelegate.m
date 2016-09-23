//
//  XLTableDelegate.m
//  ReduceViewController
//
//  Created by xl on 16/9/23.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "XLTableDelegate.h"
#import "XLBaseDataSource.h"
#import "XLBaseCell.h"
#import "NSObject+CellHeight.h"

@implementation XLTableDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.viewController respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
       return  [self.viewController tableView:tableView heightForRowAtIndexPath:indexPath];
    } else {
        XLBaseDataSource *dataSource = tableView.dataSource;
        NSObject *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
        Class cellClass = dataSource.cellClassBlock(object);
        if (object.xl_cellHeight <=0) {
            // 缓存cell高度
            CGFloat cellHeight= [cellClass tableView:tableView rowHeightForObject:object];
            object.xl_cellHeight = cellHeight;
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

@end
