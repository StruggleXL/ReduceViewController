//
//  UITableView+XLExtension.m
//  ReduceViewController
//
//  Created by xl on 16/9/23.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "UITableView+XLExtension.h"
#import <objc/message.h>

static const void *xl_tableview_reusableCell_key = "xl_tableview_xl_reusableCell_key";
static const void *xl_tableview_hasRegisterCell_key = "xl_tableview_xl_hasRegisterCell_key";
@implementation UITableView (XLExtension)

- (NSMutableDictionary *)xl_reusableCell {
    NSMutableDictionary *cells = objc_getAssociatedObject(self, xl_tableview_reusableCell_key);
    
    if (cells == nil) {
        cells = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self,
                                 xl_tableview_reusableCell_key,
                                 cells,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    
    return cells;
}
- (NSMutableDictionary *)xl_hasRegisterCell {
    NSMutableDictionary *cells = objc_getAssociatedObject(self, xl_tableview_hasRegisterCell_key);
    
    if (cells == nil) {
        cells = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self,
                                 xl_tableview_hasRegisterCell_key,
                                 cells,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    
    return cells;
}

@end
