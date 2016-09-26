//
//  XLBaseDataSource.m
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "XLBaseDataSource.h"
#import "XLBaseSectionModel.h"
#import "XLBaseCell.h"
#import <objc/runtime.h>

@interface XLBaseDataSource ()

@end

@implementation XLBaseDataSource

-(void)setSections:(NSMutableArray *)sections
{
    _sections=sections;
}
-(instancetype)initWithSections:(NSMutableArray *)sections ModelForCellClass:(cellClassWithModel)cellClassWithModel
{
    if (self=[super init]) {
        _sections=sections;
        _cellClassBlock=cellClassWithModel;
    }
    return self;
}
-(instancetype)initWithModelForCellClass:(cellClassWithModel)cellClassWithModel
{
    return [self initWithSections:nil ModelForCellClass:cellClassWithModel];
}

- (void)clearAllRows {
    self.sections = [NSMutableArray arrayWithObject:[[XLBaseSectionModel alloc] init]];
}

- (void)appendRow:(id)row {
    XLBaseSectionModel *firstSection = [self.sections objectAtIndex:0];
    [firstSection.rows addObject:row];
}
- (void)appendRows:(NSArray *)rows {
    XLBaseSectionModel *firstSection = [self.sections objectAtIndex:0];
    [firstSection.rows addObjectsFromArray:rows];
}
- (NSInteger)rowsCount {
    XLBaseSectionModel *firstSection = [self.sections objectAtIndex:0];
    return firstSection.rows.count;
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
