//
//  XLBaseSectionModel.m
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "XLBaseSectionModel.h"

@implementation XLBaseSectionModel

- (instancetype)init {
    if (self = [super init]) {
        self.rows = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
