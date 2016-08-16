//
//  XLBaseSectionModel.m
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "XLBaseSectionModel.h"

@implementation XLBaseSectionModel


-(NSMutableArray *)rows
{
    if (!_rows) {
        _rows=[NSMutableArray array];
    }
    return _rows;
}

+ (NSArray <XLBaseSectionModel *>*)sectionsWithRows:(NSArray *)rows
{
    NSMutableArray *array=[NSMutableArray array];
    XLBaseSectionModel *model=[[XLBaseSectionModel alloc]init];
    [model.rows addObjectsFromArray:rows];
    [array addObject:model];
    return array;
}
@end
