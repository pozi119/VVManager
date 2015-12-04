# VOVCManager
===============

[![License Apache](http://img.shields.io/cocoapods/l/VOVCManager.svg?style=flat)](https://raw.githubusercontent.com/pozi119/VOVCManager/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/VOVCManager.svg?style=flat)](http://cocoapods.org/?q=VOVCManager)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/VOVCManager.svg?style=flat)](http://cocoapods.org/?q=VOVCManager)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Build Status](https://travis-ci.org/ibireme/VOVCManager.svg?branch=master)](https://travis-ci.org/ibireme/VOVCManager)

页面管理器:

1. 跳转指定页面,只需要知道viewController的Class名,如果有storyboard,则需要指定storyboard名.

2. 无需添加基类.

3. 支持URLScheme跳转指定页面.

备注: 初始版本,请根据具体情况修改代码.不定时更新.

具体用法:

1. 如果不需要使用URLScheme的方式,只需要在AppDelegate.m加入代码

    [VOVCManager sharedManager];
    
2. 如果要使用URLScheme,需要在AppDelegate.m中注册想要的页面,如:

    [[VOVCManager sharedManager] registerWithSpec:@{VOVCName:@"favorite",
                                                    VOVCController:@"VOFavoriteMainController",
                                                    VOVCStoryboard:@"Main",
                                                    VOVCISPresent:@(NO)}];
                                                    
3.使用storyboard,请设置每个ViewController的Storyboard ID和对应的Class名一致.

4.其他使用请参考注释.

5.VOVCFavoriteMainController中有使用代码进行跳转的示例.

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


