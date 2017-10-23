//
//  VVRecentsMainController.m
//  VVVCManagerDemo
//
//  Created by Valo on 15/5/8.
//  Copyright (c) 2015年 valo. All rights reserved.
//

#import "VVRecentsMainController.h"
#import "VVManager.h"

@interface VVRecentsMainController ()

@end

@implementation VVRecentsMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTest:(NSString *)test{
    _test = test;
    NSLog(@"test = %@", self.test);
}

- (IBAction)showDetail {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:@"Main" aController:@"VVRecentsDetailController" parameters:@{@"recentText": @"From VVRecentsMainController"}];
    [VVManager showPageWithHop:hop];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
