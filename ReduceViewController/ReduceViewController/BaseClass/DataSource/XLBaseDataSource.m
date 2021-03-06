//
//  XLBaseDataSource.m
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "XLBaseDataSource.h"
#import "XLBaseCell.h"
#import <objc/runtime.h>

@interface XLBaseDataSource ()

@end

@implementation XLBaseDataSource

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}
- (instancetype)initWithModelForCellClass:(cellClassWithModel)cellClassWithModel
{
    if (self=[super init]) {
        _sections=[NSMutableArray array];
        _cellClassBlock=cellClassWithModel;
    }
    return self;
}
- (instancetype)initWithModelForCellClass:(cellClassWithModel)cellClassWithModel configureCellBlock:(tableViewCellConfigureBlock)aConfigureCellBlock {
    XLBaseDataSource *data = [self initWithModelForCellClass:cellClassWithModel];
    data.cellConfigureBlock = aConfigureCellBlock;
    return data;
}
//// 对sections的操作 //////
- (void)clearAllSections {
    [self.sections removeAllObjects];
}
- (void)appendSections:(NSArray *)sections {
    [self.sections addObjectsFromArray:sections];
}
//// 这4个方法是对于只有1个区时对该区中的行数进行操作//////
- (void)clearAllRows {
    self.sections = [NSMutableArray arrayWithObject:[[XLBaseSectionModel alloc] init]];
}
- (void)appendRow:(id)row {
    if (self.sections.count > 0) {
        XLBaseSectionModel *firstSection = [self.sections objectAtIndex:0];
        [firstSection.rows addObject:row];
    }
}
- (void)appendRows:(NSArray *)rows {
    if (self.sections.count > 0) {
        XLBaseSectionModel *firstSection = [self.sections objectAtIndex:0];
        [firstSection.rows addObjectsFromArray:rows];
    }
}
- (NSInteger)rowsCount {
    if (self.sections.count > 0) {
        XLBaseSectionModel *firstSection = [self.sections objectAtIndex:0];
        return firstSection.rows.count;
    }
    return 0;
}
- (void)deleteARow:(id)row {
    if (self.sections.count > 0) {
        XLBaseSectionModel *firstSection = [self.sections objectAtIndex:0];
        [firstSection.rows removeObject:row];
    }
}

//根据indexPath返回对应行model
- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sections.count > indexPath.section) {
        XLBaseSectionModel *sectionModel = [self.sections objectAtIndex:indexPath.section];
        if ([sectionModel.rows count] > indexPath.row) {
            return [sectionModel.rows objectAtIndex:indexPath.row];
        }
    }
    return nil;
}
// 根据indexPath返回对应区model
- (__kindof XLBaseSectionModel *)tableView:(UITableView *)tableView ObjectForSectionAtSection:(NSInteger)section {
    if (self.sections.count > section) {
        XLBaseSectionModel *sectionModel = [self.sections objectAtIndex:section];
        return sectionModel;
    }
    return nil;
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sections.count > section) {
        XLBaseSectionModel *sectionModel = [self.sections objectAtIndex:section];
        return sectionModel.rows.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = self.cellClassBlock(model);
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    
    XLBaseCell *cell =(XLBaseCell *)[tableView dequeueReusableCellWithIdentifier:className];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:className owner:nil options:nil]firstObject];
//    }
    [cell setModel:model];
    if (self.cellConfigureBlock) {
        self.cellConfigureBlock(cell,model);
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections ? self.sections.count : 0;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.sections.count > section) {
        XLBaseSectionModel *sectionModel = [self.sections objectAtIndex:section];
        return sectionModel.headerTitle;
    }
    return nil;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.sections.count > section) {
        XLBaseSectionModel *sectionModel = [self.sections objectAtIndex:section];
        return sectionModel.footerTitle;
    }
    return nil;
}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
@end
