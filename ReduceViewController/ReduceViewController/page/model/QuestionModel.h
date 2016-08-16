//
//  QuestionModel.h
//  Test0727
//
//  Created by xl on 16/8/4.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "XLBaseSectionModel.h"
#import "QuestionSelectModel.h"

@interface QuestionModel : XLBaseSectionModel

@property (nonatomic,copy)NSString *examinationId;
@property (nonatomic,copy)NSString *examinationName;
@property (nonatomic,copy)NSString *minselectcount;
@property (nonatomic,copy)NSString *maxselectcount;


@property (nonatomic,strong)NSMutableArray <QuestionSelectModel*>*selected;
@end
