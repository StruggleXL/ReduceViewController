//
//  XLTableDelegate.h
//  ReduceViewController
//
//  Created by xl on 16/9/23.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol XLTableViewDelegate <UITableViewDelegate>

@optional

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

// 下拉刷新触发的方法(进行网络请求)
- (void)pullDownToRefreshAction;

// 上拉加载触发的方法(进行网络请求)
- (void)pullUpToRefreshMoreAction;
@end

@interface XLTableDelegate : NSObject<XLTableViewDelegate>


@property (nonatomic, weak) id<XLTableViewDelegate>viewController;
@end
