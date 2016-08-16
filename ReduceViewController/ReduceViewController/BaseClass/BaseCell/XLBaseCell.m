//
//  XLBaseCell.m
//  TableView简化
//
//  Created by xl on 16/8/15.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "XLBaseCell.h"

@implementation XLBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(id)model
{
    _model=model;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
