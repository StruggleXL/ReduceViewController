//
//  XLBaseCell.h
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//  此类为cell基类， cell的identifier必须和类名保持一致，在子类中通过实现model的set方法，给cell绑定数据

#import <UIKit/UIKit.h>

@interface XLBaseCell : UITableViewCell

// 子类重写set方法，给cell绑定数据
@property (nonatomic,strong) id model;
/** 控件之间竖直方向总间距 warn:当使用autolayout布局时，此属性不需要赋值*/
@property (nonatomic,assign) CGFloat xl_groupTotalMargin;
/** 根据model由系统自动返回cell高度*/
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object;
@end
