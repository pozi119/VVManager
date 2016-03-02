# VOVCManager(页面管理器)

[![License Apache](http://img.shields.io/cocoapods/l/VOVCManager.svg?style=flat)](https://raw.githubusercontent.com/pozi119/VOVCManager/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/VOVCManager.svg?style=flat)](http://cocoapods.org/?q=VOVCManager)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/VOVCManager.svg?style=flat)](http://cocoapods.org/?q=VOVCManager)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Build Status](https://travis-ci.org/pozi119/VOVCManager.svg?branch=master)](https://travis-ci.org/pozi119/VOVCManager)

##功能说明
* 跳转指定页面,只需要知道viewController的Class名,如果有storyboard,则需要指定storyboard名.
* 无需添加基类.
* 支持URLScheme跳转指定页面.

##安装
* cocoapods导入: 
```ruby
pod 'VOVCManager', '~> 2.0.1-beta1'
```
* 手动导入:
  将`VOVCManager`文件夹所有源码拽入项目

##更新说明
* 将[VOVCManager sharedManager]缩减为VVManager类方法,使代码更简单
* 缩减API,使用VVHop来表示页面跳转的各种参数. VVHop支持链式编程,使代码更容易阅读
* 修改页面URL的方式,1.0.0版本将不可用.使用VVHop替换之前的VOVCRegistration
* 原VOVCManager跳转页面的API仍可用,但会有过期警告.

##使用
* 在需要的文件中导入头文件,通常在pch文件中导入,使用+load的方式初始化单例.
```objc
#import "VOVCManager.h"
```
* 需要使用URLScheme跳转,请在 (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 运行阶段加入以下代码
```objc
    VVHop *hop1 = [VVHop hopWithMethod:VVHop_Pop aStoryboard:@"Main" aController:@"VOFavoriteMainController"];
    [VVManager registerURLPath:@"favorite" forHop:hop1];
```

* 使用storyboard,请设置每个ViewController的Storyboard ID和对应的Class名一致.

* 其他使用请参考注释.

* VOVCFavoriteMainController中有使用代码进行跳转的示例.
```objc
    VVHop *hop = [VVHop makeHop:^(VVHop *hop) {
        hop.hop_method(VVHop_Push)
        .hop_aStoryboard(@"Main")
        .hop_aController(@"VORecentsDetailController")
        .hop_parameters(@{@"recentText": @"From VOFavoriteMainController"});
    }];
    [VVManager showPageWithHop:hop];
```

* 也可以不使用链式编程
```objc
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:@"Second" aController:@"VOTableViewController"];
    [VVManager showPageWithHop:hop];
```
