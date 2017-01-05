//
//  XLBaseDataSource.h
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//  此类专门处理dataSource,用initWithModelForCellClass初始化，此类中只实现了部分dataSource方法，若需要实现编辑状态（增、删、移动等），可在此类的子类中实现

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XLBaseSectionModel.h"

typedef Class (^cellClassWithModel)(id model);
typedef void (^tableViewCellConfigureBlock)(id cell, id model);

@interface XLBaseDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,copy)cellClassWithModel cellClassBlock;
@property (nonatomic,copy)tableViewCellConfigureBlock cellConfigureBlock;
@property (nonatomic, strong) NSMutableArray *sections;


- (void)clearAllSections;
- (void)appendSections:(NSArray *)sections;
//// 这4个方法是对于只有1个区时对该区中的行数进行操作//////
- (void)clearAllRows;
- (void)appendRow:(id)row;
- (void)appendRows:(NSArray *)rows;
- (NSInteger)rowsCount;
- (void)deleteARow:(id)row;

// 根据indexPath返回对应行model
- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;
// 根据indexPath返回对应区model
- (__kindof XLBaseSectionModel *)tableView:(UITableView *)tableView ObjectForSectionAtSection:(NSInteger)section;
#warning 注意：此block被copy到堆区，需要__weak修饰;根据不同的model或model相应的属性，返回不同的cell
-(instancetype)initWithModelForCellClass:(cellClassWithModel)cellClassWithModel;
- (instancetype)initWithModelForCellClass:(cellClassWithModel)cellClassWithModel configureCellBlock:(tableViewCellConfigureBlock)aConfigureCellBlock;
@end
