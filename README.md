# VOVCManager

[![License Apache](http://img.shields.io/cocoapods/l/VOVCManager.svg?style=flat)](https://raw.githubusercontent.com/pozi119/VOVCManager/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/VOVCManager.svg?style=flat)](http://cocoapods.org/?q=VOVCManager)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/VOVCManager.svg?style=flat)](http://cocoapods.org/?q=VOVCManager)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Build Status](https://travis-ci.org/pozi119/VOVCManager.svg?branch=master)](https://travis-ci.org/pozi119/VOVCManager)

页面管理器:

1. 跳转指定页面,只需要知道viewController的Class名,如果有storyboard,则需要指定storyboard名.

2. 无需添加基类.

3. 支持URLScheme跳转指定页面.

具体用法:

1. 如果不需要使用URLScheme的方式,只需要在AppDelegate.m加入代码

    	[VOVCManager sharedManager];
    
2. 如果要使用URLScheme,需要在AppDelegate.m中注册想要的页面,如:

	    [[VOVCManager sharedManager] registerWithSpec:@{VOVCName:@"favorite",
	                                                    VOVCController:@"VOFavoriteMainController",
	                                                    VOVCStoryboard:@"Main",
	                                                    VOVCISPresent:@(NO)}];
                                                    
3. 使用storyboard,请设置每个ViewController的Storyboard ID和对应的Class名一致.

4. 其他使用请参考注释.

5. VOVCFavoriteMainController中有使用代码进行跳转的示例.

		[[VOVCManager sharedManager] pushController:@"VOFavoriteDetailController" storyboard:@"Main"];

		[[VOVCManager sharedManager] pushController:@"VORecentsDetailController" storyboard:@"Main" params:@{@"recentText": @"From VOFavoriteMainController"}];

		[[VOVCManager sharedManager] pushController:@"VOTableViewController" storyboard:@"Second"];



