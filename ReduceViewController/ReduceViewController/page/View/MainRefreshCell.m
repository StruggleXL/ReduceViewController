//
//  MainRefreshCell.m
//  ReduceViewController
//
//  Created by xl on 17/1/18.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "MainRefreshCell.h"
#import "MainRefreshModel.h"
#import "UIImageView+WebCache.h"

@interface MainRefreshCell ()


@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
@property (weak, nonatomic) IBOutlet UILabel *testTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *testDescribeLabel;
@property (weak, nonatomic) IBOutlet UILabel *testAddressLabel;

@end

@implementation MainRefreshCell

- (void)setModel:(MainRefreshModel *)model {
    [super setModel:model];
    [self.testImageView sd_setImageWithURL:[NSURL URLWithString:model.course_banner_img]];
    self.testTitleLabel.text = model.course_name;
    self.testDescribeLabel.text = model.price;
    self.testAddressLabel.text = model.teacher_name;
}
- (IBAction)testClick:(id)sender {
    if (_testBlock) {
        _testBlock();
    }
}

@end
