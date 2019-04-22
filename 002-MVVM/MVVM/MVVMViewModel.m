//
//  MVVMViewModel.m
//  002-MVVM
//
//  Created by Cooci on 2018/4/1.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "MVVMViewModel.h"
#import <ReactiveObjC.h>


@implementation MVVMViewModel

//- (instancetype)init{
//    if (self == [super init]) {
//        [self addObserver:self forKeyPath:@"contenKey" options:NSKeyValueObservingOptionNew context:nil];
//    }
//    return self;
//}

- (instancetype)init{
    if (self == [super init]) {
        //订阅信号(热信号!!)    监听contenKey值的变化
        [RACObserve(self, contenKey) subscribeNext:^(id  _Nullable x) {
            NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
            [mArray removeObject:x];
            if (self.successBlock) {
                self.successBlock(mArray);
            }
        }];
    }
    return self;
}

- (void)reloadData{
    //数据一般为网络获取,获取后进行第一次回调,VC刷新页面
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];
//        [self.dataArray addObjectsFromArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.successBlock) {
                //返回block
                self.successBlock(array);
            }
        });
    });
}

//#pragma mark - KVO回调
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"%@",change);    //通过监听得知数据变化
//    //处理数据
//    NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];
//    NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
//    [mArray removeObject:change[NSKeyValueChangeNewKey]];
//    
//    //双向绑定通知VC更新变化后的数据
//    if (self.successBlock) {
//        self.successBlock(mArray);
//    }
//}
//
//- (void)dealloc
//{
//    [self removeObserver:self forKeyPath:@"contenKey"];   //移除通知
//}

@end
