//
//  XLBaseDataSource.h
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//  此类专门处理dataSource,用initWithModelForCellClass初始化，此类中只实现了部分dataSource方法，若需要实现编辑状态（增、删、移动等），可在此类的子类中实现

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef Class (^cellClassWithModel)(id model);

@interface XLBaseDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,copy)cellClassWithModel cellClassBlock;
@property (nonatomic, strong) NSMutableArray *sections;

#warning 注意：此block被copy到堆区，需要__weak修饰;根据不同的model或model相应的属性，返回不同的cell
-(instancetype)initWithSections:(NSMutableArray *)sections ModelForCellClass:(cellClassWithModel)cellClassWithModel;
-(instancetype)initWithModelForCellClass:(cellClassWithModel)cellClassWithModel;
@end
