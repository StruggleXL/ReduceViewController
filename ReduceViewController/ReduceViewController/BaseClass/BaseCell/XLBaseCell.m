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
        [tableView layoutIfNeeded];
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
        cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [tableView.xl_reusableCell setObject:cell forKey:NSStringFromClass(self)];
    }
    return cell;
}
- (void)setModel:(id)model
{
    _model=model;
}
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat rowHeight = 0;
    for (UIView *subView in self.contentView.subviews) {
        CGFloat subViewHeight = 0;
        subViewHeight = [subView sizeThatFits:subView.bounds.size].height;
        if (subViewHeight == 0) {
            subViewHeight = subView.bounds.size.height;
        }
        rowHeight += subViewHeight;
    }
    rowHeight += self.xl_groupTotalMargin;
    return CGSizeMake(size.width, rowHeight);
}
- (CGFloat)rowHeightForObject:(id)object withTableView:(UITableView *)tableView {
    [self setModel:object];
    
    // contentView宽度
    CGFloat contentViewWidth = CGRectGetWidth(tableView.frame);

    if (self.accessoryView) {
        contentViewWidth -= 16 + CGRectGetWidth(self.accessoryView.frame);
    } else {
        static const CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        contentViewWidth -= systemAccessoryWidths[self.accessoryType];
    }
    CGFloat rowHeight = 0;
    if (contentViewWidth > 0 && self.contentView.constraints.count > 0) {
        // 根据contentView宽度利用autolayout自动计算高度
        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
        [self.contentView addConstraint:widthFenceConstraint];
        
        rowHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        [self.contentView removeConstraint:widthFenceConstraint];
    }
    
    if (rowHeight == 0) {
#if DEBUG
        if (self.contentView.constraints.count > 0) {
            NSLog(@"[XLBaseCell] Warning : autolayout有问题");
        }
#endif
        // 不是用autolayout适配的cell计算高度
        rowHeight = [self sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
    }
    
    // 设置默认高度
    if (rowHeight == 0) {
        rowHeight = 44;
    }
    
    if (tableView.separatorStyle != UITableViewCellSeparatorStyleNone) {
        rowHeight += 1.0 / [UIScreen mainScreen].scale;
    }
    return rowHeight;
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
    XLBaseCell *cell = [self autoCalculatorCellHeightCellWithTableView:tableView];
    [cell prepareForReuse];
    return [cell rowHeightForObject:object withTableView:tableView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
