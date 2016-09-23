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

@end

@interface XLTableDelegate : NSObject<XLTableViewDelegate>


@property (nonatomic, weak) id<XLTableViewDelegate>viewController;
@end
