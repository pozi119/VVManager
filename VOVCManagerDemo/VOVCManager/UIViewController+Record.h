//
//  UIViewController+Record.h
//  joylife
//
//  Created by Valo on 15/4/25.
//  Copyright (c) 2015年 ValoLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Record)
/**
 *  开始记录ViewController的跳转
 */
+ (void)record;

/**
 *  停止记录ViewController的跳转
 */
+ (void)undoRecord;

@end
