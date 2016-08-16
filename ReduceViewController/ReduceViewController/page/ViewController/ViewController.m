//
//  ViewController.m
//  ReduceViewController
//
//  Created by xl on 16/8/16.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "ViewController.h"
#import "YYModel.h"
#import "XLBaseDataSource.h"
#import "QuestionModel.h"
#import "QuestionSelectModel.h"
#import "QuestionCell.h"

@interface ViewController ()<UITableViewDelegate>

@property (nonatomic,strong)XLBaseDataSource *baseDataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDelegateAndDataSource];
    
    [self loadData];
    
}
-(void)setupDelegateAndDataSource
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.tableView.delegate=self;
    //设置数据源,注意：此block被copy到堆区，需要__weak修饰
    self.baseDataSource=[[XLBaseDataSource alloc]initWithModelForCellClass:^Class(QuestionSelectModel *model) {
        return [QuestionCell class];
    }];
    self.tableView.dataSource=self.baseDataSource;
}

-(void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *dataArray=dic[@"data"];
    self.baseDataSource.sections=[[NSArray yy_modelArrayWithClass:[QuestionModel class] json:dataArray] mutableCopy];
    [self.tableView reloadData];
}
@end
