//
//  MainRefreshCell.h
//  ReduceViewController
//
//  Created by xl on 17/1/18.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "XLBaseCell.h"

typedef void(^testButtonClick)(void);

@interface MainRefreshCell : XLBaseCell

@property (nonatomic,copy) testButtonClick testBlock;
@end
