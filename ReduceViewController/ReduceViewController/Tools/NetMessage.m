//
//  NetMessage.m
//  SunRoamGuanAiJiaJia
//
//  Created by Eric on 16/12/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "NetMessage.h"

@implementation NetMessage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serverUrl = kServerURL;//设置默认值
        _header = @{};//防止_header为null
        _showLog = YES;//默认每个请求都打印log结果
        _isCheck = YES;//设置默认值
    }
    return self;
}
@end
