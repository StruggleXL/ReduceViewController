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
@end
