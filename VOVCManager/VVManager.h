//
//  VVManager.h
//  VOVCManager
//
//  Created by Valo on 16/2/24.
//  Copyright © 2016年 valo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVHop.h"

@interface VVManager : NSObject

#pragma mark - 调试信息打印开关
/**
 *  是否打印调试信息
 *
 *  @param prtDebugInfo 是否打印
 */
+ (void)setPrtDebugInfo:(BOOL)prtDebugInfo;

#pragma mark - 设置页面跳转时的额外操作
/**
 *  在viewDidAppear要处理的通用额外操作,比如统计页面是否显示
 *  通常在-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中设置
 *
 *  @param appearExtraHandler 额外操作
 */
+ (void)setAppearExtraHandler:(void (^)(UIViewController *))appearExtraHandler;

/**
 *  在viewDidDisappear要处理的通用额外操作,比如统计页面停留时间等
 *  通常在-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中设置
 *
 *  @param disappearExtraHandler 额外操作
 */
+ (void)setDisappearExtraHandler:(void (^)(UIViewController *))disappearExtraHandler;

#pragma mark - 仅供 UIViewController+VVRecord 使用
/**
 * 添加页面
 *
 *  @param viewController 当前页面
 */
+ (void)addViewController:(UIViewController *)viewController;

/**
 *  移除页面
 *
 *  @param viewController 当前页面
 */
+ (void)removeViewController:(UIViewController *)viewController;

#pragma mark - 获取页面
/**
 *  当前页面
 *
 *  @return 当前页面
 */
+ (UIViewController *)currentViewController;

/**
 *  当前导航
 *
 *  @return 当前导航
 */
+ (UINavigationController *)currentNaviController;

/**
 *  第一个页面
 *
 *  @return 第一个页面
 */
+ (UIViewController *)rootViewController;

/**
 *  第一个导航
 *
 *  @return 第一个导航
 */
+ (UINavigationController *)rootNavigationController;

#pragma mark - 页面跳转

/**
 *  根据hop设置,进行页面跳转
 *
 *  @param hop 页面跳转设置
 */
+ (void)showPageWithHop:(VVHop *)hop;

#pragma mark - 页面URL管理
/**
 *  注册页面
 *
 *  @param path 页面路径
 *  @param hop  页面跳转的各种参数
 */
+ (void)registerURLPath:(NSString *)path forHop:(VVHop *)hop;

/**
 *  取消注册页面
 *
 *  @param path 页面路径
 */
+ (void)deregisterURLPath:(NSString *)path;

/**
 *  处理URL
 *  @discussion 在AppDelegate的handleOpenURL/OpenURL等代理方法中调用
 *  url.query传递的参数只能使用字符串或数字,若参数类型和实际类型不匹配可能导致闪退
 *
 *  @param url 页面URL,url.query将解析为hop.parameters
 *
 *  @return 是否打开URL成功
 */
+ (BOOL)handleOpenURL:(NSURL *)url;


@end
