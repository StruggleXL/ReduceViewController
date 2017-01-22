//
//  TextViewController.m
//  ReduceViewController
//
//  Created by xl on 17/1/5.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "TextViewController.h"
#import "QuestionModel.h"
#import "YYModel.h"
#import "QuestionCell.h"
#import "Testios8Cell.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (Class)tableViewCellWithModel:(id)model {
    return [Testios8Cell class];
}

-(void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *dataArray=dic[@"data"];
    
    [self.baseDataSource appendSections:[NSArray yy_modelArrayWithClass:[QuestionModel class] json:dataArray]];
    [self.tableView reloadData];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50.0f;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
}
@end
