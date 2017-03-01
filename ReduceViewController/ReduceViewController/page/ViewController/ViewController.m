//
//  ViewController.m
//  ReduceViewController
//
//  Created by xl on 16/8/16.
//  Copyright © 2016年 xl. All rights reserved.
//

#import "ViewController.h"
#import "FHHFPSIndicator.h"
#import "YYModel.h"
#import "XLBaseDataSource.h"
#import "QuestionModel.h"
#import "QuestionSelectModel.h"
#import "QuestionCell.h"
#import "XLTableDelegate.h"
#import "Testios8Cell.h"

@interface ViewController ()<XLTableViewDelegate>

@property (nonatomic,strong)XLBaseDataSource *baseDataSource;
@property (nonatomic,strong)XLTableDelegate *tableDelegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 监测fps
    [[FHHFPSIndicator sharedFPSIndicator] show];
    
    [self setupDelegateAndDataSource];
    
    [self loadData];
    
}
-(void)setupDelegateAndDataSource
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    // 设置代理
    self.tableDelegate = [[XLTableDelegate alloc]init];
    self.tableDelegate.viewController = self;
    self.tableView.delegate = self.tableDelegate;

    //设置数据源,注意：此block被copy到堆区，需要__weak修饰
    self.baseDataSource=[[XLBaseDataSource alloc]initWithModelForCellClass:^Class(QuestionSelectModel *model) {
        return [QuestionCell class];
//        return [Testios8Cell class];
    }];
    self.tableView.dataSource=self.baseDataSource;
}

-(void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *dataArray=dic[@"data"];
    [self.baseDataSource appendSections:[NSArray yy_modelArrayWithClass:[QuestionModel class] json:dataArray]];
    [self.tableView reloadData];
    
//    [self performSelector:@selector(addDataWithTest) withObject:nil afterDelay:5];
}
- (void)addDataWithTest {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *dataArray=dic[@"data"];
    [self.baseDataSource appendSections:[NSArray yy_modelArrayWithClass:[QuestionModel class] json:dataArray]];
    [self.tableView reloadData];
}
 // 若实现代理方法，就会调用此方法，若不实现，XLTableDelegate会自动计算好所需行高，并缓存
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44.0f;
//}
 // 此方法直接返回点击的cell，对应的model，若同时实现该方法和下面的方法，则只会调用该方法
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    NSLog(@"object=%@,row=%ld",object,indexPath.row);
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"====");
//}
@end
