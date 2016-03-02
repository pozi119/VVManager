//
//  VVHop.h
//  VOVCManager
//  页面跳转设置
//
//  Created by Valo on 16/2/24.
//  Copyright © 2016年 valo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VVHopMethod) {
    VVHop_Push,
    VVHop_Pop,
    VVHop_Present,
    VVHop_Dismiss
};

@interface VVHop : NSObject

#pragma mark 目标页面及跳转方式
@property (nonatomic, strong) UIViewController *controller; /**< UIViewController */
@property (nonatomic, assign) VVHopMethod      method;      /**< 页面跳转方式 */

#pragma mark 基本参数,用于创建目标页面
@property (nonatomic, copy  ) NSString     *aController; /**< UIViewController类名 */
@property (nonatomic, copy  ) NSString     *aStoryboard; /**< UIStoryboard 名称 */
@property (nonatomic, strong) NSDictionary *parameters;  /**< UIViewController要设置的参数 */

#pragma mark 额外参数
@property (nonatomic, copy  ) void    (^completion)(); /**< 页面跳转完成后的操作 */
@property (nonatomic, assign) BOOL    soruceInNav;     /**< Present模式,源页面是否需要包含在UINavigationController中,默认为true */
@property (nonatomic, assign) BOOL    destInNav;       /**< Present模式,目标页面是否需要包含在UINavigationController中,默认为false */
@property (nonatomic, assign) CGFloat alpha;           /**< Present模式,目标页面背景透明度,默认为1.0 */
@property (nonatomic, assign) BOOL    animated;        /**< 页面跳转时是否有动画 */
@property (nonatomic, strong) NSArray *removeVCs;      /**< Push模式,push完成后要移除的页面 */

#pragma mark 链式编程,设置属性

- (VVHop *(^)(VVHopMethod method))hop_method;

- (VVHop *(^)(UIViewController *controller))hop_controller;

- (VVHop *(^)(NSString *aController))hop_aController;

- (VVHop *(^)(NSString *aStoryboard))hop_aStoryboard;

- (VVHop *(^)(NSDictionary *parameters))hop_parameters;

- (VVHop *(^)(void (^completion)()))hop_completion;

- (VVHop *(^)(BOOL sourceInNavi))hop_sourceInNavi;

- (VVHop *(^)(BOOL destInNavi))hop_destInNavi;

- (VVHop *(^)(CGFloat alpha))hop_alpha;

- (VVHop *(^)(BOOL animated))hop_animated;

- (VVHop *(^)(NSArray *removeVCs))hop_removeVCs;

+ (instancetype)makeHop:(void(^)(VVHop *hop))block;

#pragma mark - 工厂方法

+ (instancetype)hopWithDictionary:(NSDictionary *)dic;

+ (instancetype)hopWithMethod:(VVHopMethod)method
                   controller:(UIViewController *)controller;

+ (instancetype)hopWithMethod:(VVHopMethod)method
                   controller:(UIViewController *)controller
                   parameters:(NSDictionary *)parameters;

+ (instancetype)hopWithMethod:(VVHopMethod)method
                  aStoryboard:(NSString *)aStoryboard
                  aController:(NSString *)aController;

+ (instancetype)hopWithMethod:(VVHopMethod)method
                  aStoryboard:(NSString *)aStoryboard
                  aController:(NSString *)aController
                   parameters:(NSDictionary *)parameters;

+ (UIViewController *)viewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams;

#pragma mark - 工具类
+ (void)setParams:(NSDictionary *)params forObject:(NSObject *)obj;

@end
