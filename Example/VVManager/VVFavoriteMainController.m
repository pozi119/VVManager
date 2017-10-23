//
//  VVFavoriteMainController.m
//  VVVCManagerDemo
//
//  Created by Valo on 15/5/8.
//  Copyright (c) 2015年 valo. All rights reserved.
//

#import "VVManager.h"
#import "VVFavoriteMainController.h"

@interface VVFavoriteMainController ()

@end

@implementation VVFavoriteMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showDetail {
    VVHop *hop = [VVHop makeHop:^(VVHop *hop) {
        hop.vv_method(VVHop_Push)
        .vv_aStoryboard(@"Main")
        .vv_aController(@"VVFavoriteDetailController");
    }];
    [VVManager showPageWithHop:hop];
}

- (IBAction)toRecents {
    VVHop *hop = [VVHop makeHop:^(VVHop *hop) {
        hop.vv_method(VVHop_Push)
        .vv_aStoryboard(@"Main")
        .vv_aController(@"VVRecentsDetailController")
        .vv_parameters(@{@"recentText": @"From VVFavoriteMainController"});
    }];
    [VVManager showPageWithHop:hop];
}


- (IBAction)toBookmarks {
    VVHop *hop = [VVHop makeHop:^(VVHop *hop) {
        hop.vv_method(VVHop_Push)
        .vv_aStoryboard(@"Main")
        .vv_aController(@"VVBookmarkDetailController")
        .vv_parameters(@{@"bookmarkText": @"From VVFavoriteMainController"});
    }];
    [VVManager showPageWithHop:hop];
}

- (IBAction)toUser {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:@"Main" aController:@"VVUserDetailController" parameters:@{@"userText": @"From VVFavoriteMainController"}];
    [VVManager showPageWithHop:hop];
}

- (IBAction)toSecond {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:@"Second" aController:@"VVTableViewController"];
    [VVManager showPageWithHop:hop];
}

- (IBAction)toXib {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:nil aController:@"VVXibViewController" parameters:@{@"bgColor": [UIColor colorWithRed:0.106 green:0.733 blue:0.384 alpha:1.000]}];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentDetail {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Main" aController:@"VVFavoriteDetailController" parameters:@{@"favText": @"Present"}];
    [VVManager showPageWithHop:hop];
}


- (IBAction)presentRecents {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Main" aController:@"VVRecentsDetailController" parameters:@{@"recentText": @"Present"}];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentBookmarks {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Main" aController:@"VVBookmarkDetailController" parameters:@{@"bookmarkText": @"Present"}];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentUser {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Main" aController:@"VVUserDetailController" parameters:@{@"userText": @"Present"}];
    hop.destInNav = YES;
    [hop setCompletion:^{
        NSLog(@"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    }];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentSecond {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Second" aController:@"VVTableViewController"];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentXib {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:nil aController:@"VVXibViewController" parameters:@{@"bgColor": [UIColor colorWithRed:0.689 green:0.272 blue:0.733 alpha:1.000]}];
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
