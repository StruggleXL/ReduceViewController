//
//  NSObject+CellHeight.m
//  ReduceViewController
//
//  Created by xl on 16/9/23.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "NSObject+CellHeight.h"
#import <objc/message.h>

static const void *xl_NSObject_cellHeight_key = "xl_NSObject_cellHeight_key";


@implementation NSObject (CellHeight)


- (CGFloat)xl_cellHeight {
    return [objc_getAssociatedObject(self, xl_NSObject_cellHeight_key) floatValue];
}
- (void)setXl_cellHeight:(CGFloat)xl_cellHeight {
    objc_setAssociatedObject(self,
                             xl_NSObject_cellHeight_key,
                             [NSString stringWithFormat:@"%.1f,",xl_cellHeight],
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
