//
//  Testios8Cell.m
//  ReduceViewController
//
//  Created by xl on 16/10/17.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "Testios8Cell.h"
#import "QuestionSelectModel.h"

@interface Testios8Cell ()

@property (strong, nonatomic) UILabel *optionLabel;
@end

@implementation Testios8Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        self.optionLabel = label;
    }
    return self;
}


-(void)setModel:(QuestionSelectModel *)model
{
    [super setModel:model];
    // 必须设置preferredMaxLayoutWidth属性，和label宽度约束一致
    CGFloat ww= [UIScreen mainScreen].bounds.size.width;
//    self.optionLabel.preferredMaxLayoutWidth = ww -10 *2;
    self.optionLabel.frame = CGRectMake(10, 10, ww-20, 10);
    self.optionLabel.text=model.item_prefix;
    [self.optionLabel sizeToFit];
    self.xl_bottomSpace = 20;
}
@end
