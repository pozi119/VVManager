# VOVCManager(页面管理器) 2.1.0

[![CI Status](http://img.shields.io/travis/pozi119/VVManager.svg?style=flat)](https://travis-ci.org/pozi119/VVManager)
[![Version](https://img.shields.io/cocoapods/v/VVManager.svg?style=flat)](http://cocoapods.org/pods/VVManager)
[![License](https://img.shields.io/cocoapods/l/VVManager.svg?style=flat)](http://cocoapods.org/pods/VVManager)
[![Platform](https://img.shields.io/cocoapods/p/VVManager.svg?style=flat)](http://cocoapods.org/pods/VVManager)

##版本更新
* 打印调试信息改为[VVManager setVerbose:YES].
* 链式编程设置属性前缀改为vv_.
* 添加两个通知:VVManagerViewDidAppearNotification,VVManagerViewDidDisappearNotification


##功能说明
* 跳转指定页面,只需要知道viewController的Class名,如果有storyboard,则需要指定storyboard名.
* 支持URLScheme跳转指定页面.

##安装
* cocoapods导入: 
```ruby
pod 'VVManager'
```
* 手动导入:
  将`VOVCManager`文件夹所有源码拽入项目

##更新说明
* V2.0.9 仍使用NSMutableArray保存页面列表.添加reset方法重置列表,在某些特殊场景使用.

##使用
* 在需要的文件中导入头文件,通常在pch文件中导入,使用+load的方式初始化单例.
```objc
#import "VVManager.h"
```
* 需要使用URLScheme跳转,请在 (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 运行阶段加入以下代码
```objc
    // 在Safari mobile或者其他支持URLScheme的浏览器中打开 app://favorite 即可打开该页面
    [VVManager registerURLPath:@"favorite" forHop:[VVHop hopWithMethod:VVHop_Pop aStoryboard:@"Main" aController:@"VVFavoriteMainController"]];
```

* 使用storyboard,请设置每个ViewController的Storyboard ID和对应的Class名一致.

* 其他使用请参考注释.

* VOVCFavoriteMainController中有使用代码进行跳转的示例.
```objc
    [VVManager showPageWithHop:[VVHop makeHop:^(VVHop *hop) {
        hop.vv_method(VVHop_Push)
        .vv_aStoryboard(@"Main")
        .vv_aController(@"VVRecentsDetailController")
        .vv_parameters(@{@"recentText": @"From VVFavoriteMainController"});
    }]];
```

* 也可以不使用链式编程
```objc
    [VVManager showPageWithHop:[VVHop hopWithMethod:VVHop_Push aStoryboard:@"Second" aController:@"VVTableViewController"]];
```

pozi119, pozi119@163.com

## License

VVManager is available under the MIT license. See the LICENSE file for more info.
