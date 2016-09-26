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



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLBaseDataSource *dataSource = tableView.dataSource;
    NSObject *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = dataSource.cellClassBlock(object);
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    if (![tableView.xl_hasRegisterCell objectForKey:className]) {
        @try {
            // 通过xib创建的cell
            [[NSBundle mainBundle]loadNibNamed:className owner:nil options:nil];
            [tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
        } @catch (NSException *exception) {
            if (![tableView dequeueReusableCellWithIdentifier:className]) {
                // 通过代码创建的cell
                [tableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
            } else {
                // 通过storyboard创建的cell，不需任何处理
            }
            
        } @finally {
            // 保存已注册标记
            [tableView.xl_hasRegisterCell setObject:@(YES) forKey:className];
        }
    }
    if ([self.viewController respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
       return  [self.viewController tableView:tableView heightForRowAtIndexPath:indexPath];
    } else {
        
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
