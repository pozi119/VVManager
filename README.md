# VOVCManager
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
                                                    VOVCShowType:@(VVMSHowPush)}];
3.使用storyboard,请设置每个ViewController的Storyboard ID和对应的Class名一致.
4.其他使用请参考注释.
