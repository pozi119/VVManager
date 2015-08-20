//
//  VOFavoriteMainController.m
//  VOVCManagerDemo
//
//  Created by Valo on 15/5/8.
//  Copyright (c) 2015年 valo. All rights reserved.
//

#import "VOVCManager.h"
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
    [[VOVCManager sharedManager] pushController:@"VOFavoriteDetailController" storyboard:@"Main"];
}

- (IBAction)toRecents {
    [[VOVCManager sharedManager] pushController:@"VORecentsDetailController" storyboard:@"Main" params:@{@"recentText": @"From VOFavoriteMainController"}];
}

- (IBAction)toBookmarks {
    [[VOVCManager sharedManager] pushController:@"VOBookmarkDetailController" storyboard:@"Main" params:@{@"bookmarkText": @"From VOFavoriteMainController"} animated:NO];
    
}

- (IBAction)toUser {
    [[VOVCManager sharedManager] pushController:@"VOUserDetailController" storyboard:@"Main"  params:@{@"userText": @"From VOFavoriteMainController", @"animated":@(YES)}];
}

- (IBAction)toSecond {
    [[VOVCManager sharedManager] pushController:@"VOTableViewController" storyboard:@"Second"];
}

- (IBAction)toXib {
    [[VOVCManager sharedManager] pushController:@"VOXibViewController" storyboard:nil  params:@{@"bgColor": [UIColor colorWithRed:0.106 green:0.733 blue:0.384 alpha:1.000]}];
}

- (IBAction)presentDetail {
    [[VOVCManager sharedManager] presentViewController:@"VOFavoriteDetailController" storyboard:@"Main" params:@{@"favText": @"Present"}];
}


- (IBAction)presentRecents {
    [[VOVCManager sharedManager] presentViewController:@"VORecentsDetailController" storyboard:@"Main" params:@{@"recentText": @"Present"}];
}

- (IBAction)presentBookmarks {
    [[VOVCManager sharedManager] presentViewController:@"VOBookmarkDetailController" storyboard:@"Main" params:@{@"bookmarkText": @"Present"} isInNavi:NO];
    
}

- (IBAction)presentUser {
    [[VOVCManager sharedManager] presentViewController:@"VOUserDetailController" storyboard:@"Main"  params:@{@"userText": @"Present", @"animated":@(YES)} isInNavi:YES completion:^{
        NSLog(@"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    }];
}

- (IBAction)presentSecond {
    [[VOVCManager sharedManager] presentViewController:@"VOTableViewController" storyboard:@"Second"];
}

- (IBAction)presentXib {
    [[VOVCManager sharedManager] presentViewController:@"VOXibViewController" storyboard:nil  params:@{@"bgColor": [UIColor colorWithRed:0.689 green:0.272 blue:0.733 alpha:1.000]}];
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
