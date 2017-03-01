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
    self.contentView.bounds = [UIScreen mainScreen].bounds;
}
-(void)setModel:(QuestionSelectModel *)model
{
    [super setModel:model];
    
    self.optionLabel.text=model.item_prefix;
}

@end
