//
//  UIViewController+Record.m
//  joylife
//
//  Created by Valo on 15/4/25.
//  Copyright (c) 2015年 ValoLee. All rights reserved.
//

#import "UIViewController+VVRecord.h"
#import "VVManager.h"
#import "NSObject+VVRuntime.h"

@implementation UIViewController (Record)

static BOOL isRecorded;

#pragma mark - 替代方法

-(void)recordViewDidAppear:(BOOL)animated{
    [VVManager addViewController:self];
    [self recordViewDidAppear:animated];
}

-(void)recordViewDidDisappear:(BOOL)animated{
    [VVManager removeViewController:self];
    [self recordViewDidDisappear:animated];
}

#pragma mark - 方法替代
+ (void)record{
    if (isRecorded){
        return;
    }
    [[self class] swizzleMethod:@selector(viewDidAppear:) withMethod:@selector(recordViewDidAppear:)];
    [[self class] swizzleMethod:@selector(viewDidDisappear:) withMethod:@selector(recordViewDidDisappear:)];
    
    isRecorded = YES;
}

+ (void)undoRecord{
    if (!isRecorded){
        return;
    }
    
    isRecorded = NO;
    [[self class] swizzleMethod:@selector(recordViewDidAppear:) withMethod:@selector(viewDidAppear:)];
    [[self class] swizzleMethod:@selector(recordViewDidDisappear:) withMethod:@selector(viewDidDisappear:)];
}

@end
