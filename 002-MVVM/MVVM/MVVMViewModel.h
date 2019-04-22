//
//  MVVMViewModel.h
//  002-MVVM
//
//  Created by Cooci on 2018/4/1.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewModelClass.h" 

@interface MVVMViewModel : ViewModelClass

//@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *contenKey;   //通过KVO监听该值,当该值发生改变后更新数据,回调VC

- (void)reloadData;

@end
