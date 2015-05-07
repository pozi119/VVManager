//
//  VOVCManager.h
//  joylife
//
//  Created by Valo on 15/4/25.
//  Copyright (c) 2015年 ValoLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Record.h"

UIKIT_EXTERN NSString const *VOVCName;
UIKIT_EXTERN NSString const *VOVCController;
UIKIT_EXTERN NSString const *VOVCStoryboard;
UIKIT_EXTERN NSString const *VOVCShowType;
UIKIT_EXTERN NSString const *VOVCStyle;


typedef NS_ENUM(NSUInteger, VVMShowMode) {
    /** 未指定,优先尝试push,之后尝试present */
    VVMShowUnspecified = 0,
    /** push方式,必须有UINavigationController */
    VVMSHowPush    = 1,
    /** present 方式*/
    VVMShowPresent = 2,
    /** 暂时不支持,后续考虑加入 */
    VVMSHOWEmbed   = 4,
};

/**
 * @brief 页面管理器
 *
 * @brief 1.支持直接跳转页面
 * @brief 2.支持URL方式
 * @brief 3.参数传递,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 * @brief 4.URL方式传参,对应参数必须是string类型的.
 */
@interface VOVCManager : NSObject

/**
 *  ViewController管理器单例对象
 *
 *  @return 单例对象
 */
+ (instancetype)sharedManager;

/**
 *  当前页面
 */
@property (nonatomic, weak, readonly) UIViewController *currentViewController;

/**
 *  添加一个ViewController到管理器,主要提供给UIViewController+Record使用
 *
 *  @param viewController 要添加的ViewController
 */
- (void)addViewController:(UIViewController *)viewController;

/**
 *  从管理器删除一个ViewController
 *
 *  @param viewController 要删除的ViewController,主要提供给UIViewController+Record使用
 */
- (void)removeViewController:(UIViewController *)viewController;

#pragma mark - 页面创建
/**
 *  从xib,storyboard或者代码生成页面，默认无参数
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *
 *  @return 页面对象
 */
- (UIViewController *)viewController:(NSString *)aController storyboard:(NSString *)aStoryboard;

/**
 *  从storyboard生成页面
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置),aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *
 *  @return 页面对象
 */
- (UIViewController *)viewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams;


#pragma mark - 页面跳转,Push
/**
 *  页面跳转，默认有push动画，默认无参数
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 */
- (void)pushController:(NSString *)aController storyboard:(NSString *)aStoryboard;

/**
 *  页面跳转,默认有push动画
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 */
- (void)pushController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams;

/**
 *  页面跳转,默认参数
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param animated    是否动画
 */
- (void)pushController:(NSString *)aController storyboard:(NSString *)aStoryboard animated:(BOOL)animated;

/**
 *  页面跳转
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param animated    是否动画
 */
- (void)pushController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams animated:(BOOL)animated;


#pragma mark - 页面出栈
/**
 *  页面弹出，默认无参数，默认有动画
 *
 *  @param aController 目标页面
 *  @param aStoryboard 目标页面所在的storyboard
 *
 *  @return 出栈页面数组
 */
- (NSArray *)popToViewController:(NSString *)aController storyboard:(NSString *)aStoryboard;

/**
 *  页面弹出，默认有动画
 *
 *  @param aController 目标页面
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *
 *  @return 出栈页面数组
 */
- (NSArray *)popToViewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams;

/**
 *  页面弹出
 *
 *  @param aController 目标页面
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param animated    是否有动画
 *
 *  @return 出栈页面数组
 */
- (NSArray *)popToViewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams animated:(BOOL)animated;

#pragma mark - 页面显示,present
/**
 *  弹出模态页面，默认无参数，默认生成新navigationController
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 */
- (void)presentViewController:(NSString *)aController storyboard:(NSString *)aStoryboard;

/**
 *  弹出模态页面，默认生成新navigationController
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 */
- (void)presentViewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams;

/**
 *  弹出模态页面
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param inNavi      目标页面是否包含在UINavigationController中
 */
- (void)presentViewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams isInNavi:(BOOL)inNavi;

/**
 *  弹出模态页面
 *
 *  @param aController 目标页面,请在storyboard中设置和class名相同的storyboard id
 *  @param aStoryboard 目标页面所在的storyboard
 *  @param aParams     页面参数,aParams的每个key和viewController的属性对应(通过key-value方式设置)
 *  @param inNavi      目标页面是否包含在UINavigationController中
 *  @param completion  页面显示动画完成后的操作
 */
- (void)presentViewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams isInNavi:(BOOL)inNavi completion:(void (^)(void))completion;

#pragma mark - 页面URL管理
/**
 *  注册页面信息
 *
 *  @param spec 页面信息
 *
 */
- (void)registerWithSpec:(NSDictionary *)spec;

/**
 *  注册页面路径
 *
 *  @param name        页面注册名
 *  @param aController 页面ViewController类名
 *  @param aStoryboard nil表示从xib或者代码创建,否则从制定的Storyboard创建
 *  @param showMode    显示方式,present或者push
 *  @param style       显示动画,UIModalTransitionStyle. showMode为present时可用
 */
- (void)registerName:(NSString *)name forViewController:(NSString *)aController inStoryboard:(NSString *)aStoryboard showMode:(VVMShowMode)showMode presentStyle:(UIModalTransitionStyle)style;

/**
 *  取消注册页面路径
 *
 *  @param name 要取消的页面注册名
 */
- (void)cancelRegisterName:(NSString *)name;

/**
 *  处理页面跳转URL
 *
 *  @param url 要处理的URL路径,URL的scheme必须和APP的scheme匹配.如果要传递参数,只支持string类型的(key和目标页面属性对应,这些属性必须是NSString类型)
 *
 *  @return 是否处理成功
 */
- (BOOL)handleOpenURL:(NSURL *)url;

@end
