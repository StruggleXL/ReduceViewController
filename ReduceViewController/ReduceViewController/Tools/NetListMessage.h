//
//  NetListMessage.h
//  ReduceViewController
//
//  Created by xl on 17/1/12.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "NetMessage.h"

@interface NetListMessage : NetMessage

/** 每页容量*/
@property (nonatomic,assign) NSInteger pageSize;
/** 当前页面*/
@property (nonatomic,assign) NSInteger currentPage;
/** 总页面*/
@property (nonatomic,assign) NSInteger totalPage;

@end
