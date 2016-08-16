//
//  QuestionSelectModel.h
//  Test0727
//
//  Created by xl on 16/8/4.
//  Copyright © 2016年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionSelectModel : NSObject


@property (nonatomic,copy)NSString *item_prefix;
@property (nonatomic,copy)NSString *idNum;
@property (nonatomic,copy)NSString *item_value;
@property (nonatomic,copy)NSString *item_desc;


@property (nonatomic)BOOL select;

@end
