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
@property (nonatomic,strong)id model;
@end
