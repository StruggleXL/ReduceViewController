//
//  QuestionModel.m
//  Test0727
//
//  Created by xl on 16/8/4.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"rows":@"options"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rows" : [QuestionSelectModel class]};
}
-(NSMutableArray<QuestionSelectModel *> *)selected
{
    if (!_selected) {
        self.selected=[NSMutableArray array];
    }
    return _selected;
}
-(NSString *)headerTitle
{
    return self.examinationName;
}
@end
