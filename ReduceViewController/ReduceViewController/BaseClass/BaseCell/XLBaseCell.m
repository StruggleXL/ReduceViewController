//
//  XLBaseCell.m
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "XLBaseCell.h"
#import "UITableView+XLExtension.h"

@implementation XLBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/** 获取自动计算高度的同一个cell*/
+ (nullable __kindof UITableViewCell *)autoCalculatorCellHeightCellWithTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView.xl_reusableCell objectForKey:NSStringFromClass(self)];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
        [tableView.xl_reusableCell setObject:cell forKey:NSStringFromClass(self)];
    }
    return cell;
}
-(void)setModel:(id)model
{
    _model=model;
}
- (CGFloat)rowHeightForObject:(id)object {
    [self setModel:object];
    [self layoutIfNeeded];
    
    CGFloat rowHeight = 0.0f;
    
    for (UIView *bottomView in self.contentView.subviews) {
        if (rowHeight < CGRectGetMaxY(bottomView.frame)) {
            rowHeight = CGRectGetMaxY(bottomView.frame);
        }
    }
    
    rowHeight += self.xl_bottomSpace;
    return rowHeight;
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
    XLBaseCell *cell = [self autoCalculatorCellHeightCellWithTableView:tableView];
    return [cell rowHeightForObject:object];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
