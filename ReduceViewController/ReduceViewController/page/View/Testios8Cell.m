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
@property (strong,nonatomic) UIImageView *myImageView;
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
        
        UIImageView *myImageView = [[UIImageView alloc]init];
        myImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:myImageView];
        self.myImageView = myImageView;
    }
    return self;
}

- (void)setModel:(QuestionSelectModel *)model
{
    [super setModel:model];
    CGFloat ww= [UIScreen mainScreen].bounds.size.width;
    self.optionLabel.frame = CGRectMake(10, 10, ww-20, 10);
    self.optionLabel.text=model.item_prefix;
    [self.optionLabel sizeToFit];
    self.myImageView.frame = CGRectMake(0, CGRectGetMaxY(self.optionLabel.frame), ww, ww *9 /16.0);
    self.xl_groupTotalMargin = 20;
}
@end
