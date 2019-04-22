//
//  ViewModelClass.h
//  002-MVVM
//
//  Created by 汇晨 on 2018/6/26.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id data);
typedef void (^ErrorCodeBlock) (id data);;

@interface ViewModelClass : NSObject
@property (copy, nonatomic) ReturnValueBlock successBlock;
@property (copy, nonatomic) ErrorCodeBlock errorBlock;


// 传入交互的Block块
- (void)initWithBlock: (ReturnValueBlock) successBlock
            WithErrorBlock: (ErrorCodeBlock) errorBlock;
@end

