//
//  ViewModelClass.m
//  002-MVVM
//
//  Created by 汇晨 on 2018/6/26.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewModelClass.h"

@implementation ViewModelClass

#pragma 接收传过来的block
- (void)initWithBlock: (ReturnValueBlock) successBlock
            WithErrorBlock: (ErrorCodeBlock) errorBlock
{
    _successBlock = successBlock;
    _errorBlock = errorBlock;
}

@end
