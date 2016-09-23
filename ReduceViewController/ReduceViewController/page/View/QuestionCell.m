//
//  QuestionCell.m
//  TableView简化
//
//  Created by xl on 16/8/16.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "QuestionCell.h"
#import "QuestionSelectModel.h"

@interface QuestionCell ()

@property (weak, nonatomic) IBOutlet UILabel *optionLabel;
@end

@implementation QuestionCell
- (void)awakeFromNib {
    [super awakeFromNib];
//    self.selectionStyle=UITableViewCellSelectionStyleNone;
}
-(void)setModel:(QuestionSelectModel *)model
{
    [super setModel:model];
    // 必须设置preferredMaxLayoutWidth属性，和label宽度约束一致
    CGFloat ww= [UIScreen mainScreen].bounds.size.width;
    self.optionLabel.preferredMaxLayoutWidth = ww -10 *2;
    
    self.optionLabel.text=model.item_prefix;
    self.xl_bottomSpace = 20;
}

@end
