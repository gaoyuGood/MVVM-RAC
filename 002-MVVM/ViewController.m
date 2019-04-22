//
//  ViewController.m
//  002-MVVM
//
//  Created by Cooci on 2018/4/1.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "MVVMViewModel.h"
#import "MVVMView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSString *const reuserId = @"reuserId";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MVVMViewModel *vm;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
//    NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];
    
    self.vm = [[MVVMViewModel alloc] init];
    __weak typeof(self) weakSelf = self;
    //model -> UI -> 代码块
    [self.vm initWithBlock:^(id data) {
        //获取到更新后的数据，刷新UI
        NSArray *array = data;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:array];
        
        MVVMView *view = [[MVVMView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (array.count + 1)/4*50)];
        [view headViewWithData:array];
        weakSelf.tableView.tableHeaderView = view;
//        [weakSelf.dataArray addObjectsFromArray:self.vm.dataArray];
        [weakSelf.tableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    }];
    
    [self.vm reloadData];
    
    
    
}

/**
 afn (id data)Block{
 
 } fail{
 
 }
 
 */



#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserId];
    }
    return cell;
}


#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.vm.contenKey = self.dataArray[indexPath.row];
    //这里通过修改MVVMViewModel的contenKey来更新数据(触发通知方法)，更新好的数据在通过block回调到VC中，完成了MVVM的双向绑定
}


#pragma mark - lazy

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserId];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
