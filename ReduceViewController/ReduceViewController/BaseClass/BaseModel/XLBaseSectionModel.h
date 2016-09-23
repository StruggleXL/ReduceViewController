//
//  XLBaseSectionModel.h
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//  显示每个区数据的model的基类，rows为此区中所有行的数据model组成的数组
//  以后所有的区model都继承此类，可在子类中实现headerTitle、footerTitle的get方法，为其赋值；在子类中实现映射方法，将存储每行数据的数组改为rows

#import <Foundation/Foundation.h>

@interface XLBaseSectionModel : NSObject

@property (nonatomic, copy) NSString *headerTitle; 
@property (nonatomic, copy) NSString *footerTitle;
//存储每行model的数组
@property (nonatomic, strong) NSMutableArray *rows;


@end
