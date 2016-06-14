//
//  VOFavoriteMainController.m
//  VOVCManagerDemo
//
//  Created by Valo on 15/5/8.
//  Copyright (c) 2015年 valo. All rights reserved.
//

#import "VVManager.h"
#import "VOFavoriteMainController.h"

@interface VOFavoriteMainController ()

@end

@implementation VOFavoriteMainController

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
        hop.hop_method(VVHop_Push)
        .hop_aStoryboard(@"Main")
        .hop_aController(@"VOFavoriteDetailController");
    }];
    [VVManager showPageWithHop:hop];
}

- (IBAction)toRecents {
    VVHop *hop = [VVHop makeHop:^(VVHop *hop) {
        hop.hop_method(VVHop_Push)
        .hop_aStoryboard(@"Main")
        .hop_aController(@"VORecentsDetailController")
        .hop_parameters(@{@"recentText": @"From VOFavoriteMainController"});
    }];
    [VVManager showPageWithHop:hop];
}


- (IBAction)toBookmarks {
    VVHop *hop = [VVHop makeHop:^(VVHop *hop) {
        hop.hop_method(VVHop_Push)
        .hop_aStoryboard(@"Main")
        .hop_aController(@"VOBookmarkDetailController")
        .hop_parameters(@{@"bookmarkText": @"From VOFavoriteMainController"});
    }];
    [VVManager showPageWithHop:hop];
}

- (IBAction)toUser {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:@"Main" aController:@"VOUserDetailController" parameters:@{@"userText": @"From VOFavoriteMainController"}];
    [VVManager showPageWithHop:hop];
}

- (IBAction)toSecond {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:@"Second" aController:@"VOTableViewController"];
    [VVManager showPageWithHop:hop];
}

- (IBAction)toXib {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:nil aController:@"VOXibViewController" parameters:@{@"bgColor": [UIColor colorWithRed:0.106 green:0.733 blue:0.384 alpha:1.000]}];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentDetail {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Main" aController:@"VOFavoriteDetailController" parameters:@{@"favText": @"Present"}];
    [VVManager showPageWithHop:hop];
}


- (IBAction)presentRecents {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Main" aController:@"VORecentsDetailController" parameters:@{@"recentText": @"Present"}];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentBookmarks {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Main" aController:@"VOBookmarkDetailController" parameters:@{@"bookmarkText": @"Present"}];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentUser {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Main" aController:@"VOUserDetailController" parameters:@{@"userText": @"Present"}];
    hop.destInNav = YES;
    [hop setCompletion:^{
        NSLog(@"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    }];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentSecond {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:@"Second" aController:@"VOTableViewController"];
    [VVManager showPageWithHop:hop];
}

- (IBAction)presentXib {
    VVHop *hop = [VVHop hopWithMethod:VVHop_Present aStoryboard:nil aController:@"VOXibViewController" parameters:@{@"bgColor": [UIColor colorWithRed:0.689 green:0.272 blue:0.733 alpha:1.000]}];
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
