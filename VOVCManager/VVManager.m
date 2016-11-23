//
//  VVManager.m
//  VOVCManagerDemo
//
//  Created by Valo on 16/2/24.
//  Copyright © 2016年 valo. All rights reserved.
//

#import "VVManager.h"
#import "UIViewController+VVRecord.h"

@interface VVManager ()
@property (nonatomic, assign) BOOL  prtDebugInfo;              ///< 打印页面切换
@property (nonatomic, assign) BOOL  appearFlag;                ///< 标记App是否完成加载
@property (nonatomic, strong) VVHop *planHop;                  ///< 准备显示的页面
@property (nonatomic, strong) NSArray *ignoredViewControllers; ///< 排除记录的页面
@property (nonatomic, strong) NSArray *flagControllers;        ///< 标记App已完成加载的页面
@property (nonatomic, strong) NSMutableDictionary *urlRegList; ///< 页面url注册
@property (nonatomic, strong) NSMutableArray *viewControllers; ///< 已加载的页面
@property (nonatomic, strong) NSMutableArray *naviControllers; ///< 已加载的导航页
@property (nonatomic, copy  ) void (^appearExtraHandler)(UIViewController *);
@property (nonatomic, copy  ) void (^disappearExtraHandler)(UIViewController *);
@end

@implementation VVManager

#pragma mark - 管理器,单例
+ (instancetype)sharedManager{
    static VVManager *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[VVManager alloc] init];
    });
    return _sharedManager;
}

#pragma mark - 初始化
+ (void)load{
    [[VVManager sharedManager] commonInit];
}

- (void)commonInit{
    _urlRegList = @{}.mutableCopy;
    _viewControllers = @[].mutableCopy;
    _naviControllers = @[].mutableCopy;
    _ignoredViewControllers  = @[@"UIInputWindowController",
                                 @"UICompatibilityInputViewController",
                                 @"UIKeyboardCandidateGridCollectionViewController",
                                 @"UIInputViewController",
                                 @"UIApplicationRotationFollowingControllerNoTouches",
                                 @"_UIRemoteInputViewController",
                                 @"PLUICameraViewController"];
    [UIViewController record];
}

#pragma mark - UIViewController+VVRecord使用
+ (void)addViewController:(UIViewController *)viewController{
    [[VVManager sharedManager] appearController:viewController];
}

+ (BOOL)utilsArray:(NSArray *)array containsString:(NSString *)string{
    BOOL contain = NO;
    for (NSString *str in array) {
        if ([str isEqualToString:string]){
            contain = YES;
            break;
        }
    }
    return contain;
}

- (void)appearController:(UIViewController *)viewController{
    NSString *vcStr = NSStringFromClass([viewController class]);
    BOOL ignore = [[self class] utilsArray:_ignoredViewControllers containsString:vcStr];
    if (ignore) { return;}
    if ([viewController isKindOfClass:[UIViewController class]]) {
        [_viewControllers addObject:viewController];
        [self printPathWithTag:@"Appear   " controller:viewController];
        if(self.appearExtraHandler){
            self.appearExtraHandler(viewController);
        }
    }
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [_naviControllers addObject:viewController];
    }
    if(!_appearFlag){
        if (_flagControllers.count == 0 || [[self class] utilsArray:_flagControllers containsString:vcStr]) {
            _appearFlag = YES;
            if (_planHop) {
                [[self class] showPageWithHop:_planHop];
            }
        }
    }
}

+ (void)removeViewController:(UIViewController *)viewController{
    [[VVManager sharedManager] disappearController:viewController];
}

- (void)disappearController:(UIViewController *)viewController{
    NSString *vcStr = NSStringFromClass([viewController class]);
    BOOL ignore = [[self class] utilsArray:_ignoredViewControllers containsString:vcStr];
    if (ignore) { return;}
    if ([viewController isKindOfClass:[UIViewController class]]) {
        [_viewControllers removeObject:viewController];
    }
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [_naviControllers removeObject:viewController];
    }

    [self printPathWithTag:@"Disappear" controller:viewController];
    if (self.disappearExtraHandler) {
        self.disappearExtraHandler(viewController);
    }
}

#pragma mark - 打印信息
+ (void)setPrtDebugInfo:(BOOL)prtDebugInfo{
    [VVManager sharedManager].prtDebugInfo = prtDebugInfo;
}

- (void)printPathWithTag:(NSString *)tag controller:(UIViewController *)controller{
    if(self.prtDebugInfo){
        NSLog(@"%@:-->(%@|%@) %@", tag,@(_naviControllers.count), @(_viewControllers.count), controller.description);
    }
}

#pragma mark - 设置页面跳转时的额外操作
+ (void)setAppearExtraHandler:(void (^)(UIViewController *))appearExtraHandler{
    [VVManager sharedManager].appearExtraHandler = appearExtraHandler;
}

+ (void)setDisappearExtraHandler:(void (^)(UIViewController *))disappearExtraHandler{
    [VVManager sharedManager].disappearExtraHandler = disappearExtraHandler;
}

+ (void)setFlagControllers:(NSArray *)flagControllers{
    [VVManager sharedManager].flagControllers = flagControllers;
}
#pragma mark - 获取页面

- (UIViewController *)currentViewController{
    return _viewControllers.lastObject;
}

+ (UIViewController *)currentViewController{
    return [VVManager sharedManager].currentViewController;
}

- (UINavigationController *)currentNaviController{
    if ([_viewControllers.lastObject isKindOfClass:[UINavigationController class]]) {
        return _viewControllers.lastObject;
    }
    if (self.currentViewController.navigationController) {
        return self.currentViewController.navigationController;
    }
    return _naviControllers.lastObject;
}

+ (UINavigationController *)currentNaviController{
    return [VVManager sharedManager].currentNaviController;
}

- (UIViewController *)rootViewController{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *controller = window.rootViewController;
    if ([controller isKindOfClass:[UINavigationController class]]) {
        controller = [(UINavigationController *)controller viewControllers].firstObject;
    }
    if ([controller isKindOfClass:[UITabBarController class]]) {
        controller = [(UITabBarController *)controller viewControllers].firstObject;
    }
    return controller;
}

+ (UIViewController *)rootViewController{
    return [VVManager sharedManager].rootViewController;
}

- (UINavigationController *)rootNavigationController{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *controller = window.rootViewController;
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)controller;
    }
    return controller.navigationController;
}

+ (UINavigationController *)rootNavigationController{
    return [VVManager sharedManager].rootNavigationController;
}

+ (void)reset{
    [[VVManager sharedManager].viewControllers removeAllObjects];
    [[VVManager sharedManager].naviControllers removeAllObjects];
}

#pragma mark - 页面跳转
+ (void)pushWithHop:(VVHop *)hop{
    if (!hop.controller) {
        return;
    }
    hop.controller.hidesBottomBarWhenPushed = !hop.showBottomBarWhenPushed;
    UINavigationController *nav = [VVManager currentNaviController];
    [nav pushViewController:hop.controller animated:hop.animated];
    if (hop.removeVCs.count > 0) {
        // Fix bug, 2016.7.18, by Valo.
        // 1. 延迟1s之后再移除指定页面,防止连续快速push时,移除了要显示的页面.
        // 2. 若页面跳转动画时间过长,请单独处理移除页面的操作.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *existVCs = nav.viewControllers.mutableCopy;
            __block NSMutableArray *willRemoveVCs = @[].mutableCopy;
            [existVCs enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
                NSString *vcName = NSStringFromClass([vc class]);
                for (NSString *rvc in hop.removeVCs) {
                    if ([rvc isEqualToString:vcName]) {
                        [willRemoveVCs addObject:vc];
                        break;
                    }
                }
            }];
            [existVCs removeObjectsInArray:willRemoveVCs];
            nav.viewControllers = existVCs;
        });
    }
}

+ (void)popWithHop:(VVHop *)hop{
    if (!hop.controller) {
        [[VVManager currentNaviController] popViewControllerAnimated:hop.animated];
    }
    else{
        UINavigationController *nav = [VVManager currentNaviController];
        NSArray *existVCs = nav.viewControllers;
        UIViewController *destVC = nil;
        for (UIViewController *vc in existVCs) {
            NSString *vcName = NSStringFromClass([vc class]);
            NSString *hopName = NSStringFromClass([hop.controller class]);
            if ([vcName isEqualToString:hopName]) {
                destVC = vc;
            }
        }
        if (destVC) {
            [VVHop setParams:hop.parameters forObject:destVC];
            [nav popToViewController:destVC animated:hop.animated];
        }
        else{
            [VVManager pushWithHop:hop];
        }
    }
}

+ (void)presentWithHop:(VVHop *)hop{
    if (!hop.controller) {
        return;
    }
    UIViewController *sourceVC = [VVManager currentViewController];
    UINavigationController *nav = [VVManager currentNaviController];
    if (hop.soruceInNav && nav != nil) {
        sourceVC = nav;
    }
    UIViewController *destVC = hop.controller;
    if (hop.destInNav) {
        if (destVC.navigationController) {
            destVC = destVC.navigationController;
        }
        else{
            destVC = [[UINavigationController alloc] initWithRootViewController:destVC];
        }
    }
    if (hop.alpha < 1.0 && hop.alpha >= 0.0) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            destVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
            UIColor *color = hop.controller.view.backgroundColor;
            color = [color colorWithAlphaComponent:hop.alpha];
            hop.controller.view.backgroundColor = color;
        }
        else{
            destVC.modalPresentationStyle = UIModalPresentationCurrentContext;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:sourceVC.view.bounds];
            imageView.image = [[self class] captureView:sourceVC.view backgroundColor:[UIColor blackColor]];
            imageView.alpha = 0.3;
            destVC.view.backgroundColor = [UIColor clearColor];
            [destVC.view addSubview:imageView];
            [destVC.view sendSubviewToBack:imageView];
        }
    }
    [VVHop setParams:hop.parameters forObject:destVC];
    [sourceVC presentViewController:destVC animated:hop.animated completion:hop.completion];
}

+ (void)dismissWithHop:(VVHop *)hop{
    [[VVManager currentViewController] dismissViewControllerAnimated:hop.animated completion:hop.completion];
}

+ (void)showPageWithHop:(VVHop *)hop{
    switch (hop.method) {
        case VVHop_Push:{
            [self pushWithHop:hop];
            break;
        }
        case VVHop_Pop:{
            [self popWithHop:hop];
            break;
        }
        case VVHop_Present:{
            [self presentWithHop:hop];
            break;
        }
        case VVHop_Dismiss: {
            [self dismissWithHop:hop];
            break;
        }
    }
}

#pragma mark - URL跳转
+ (void)registerURLPath:(NSString *)path forHop:(VVHop *)hop{
    [VVManager sharedManager].urlRegList[path] = hop;
}

+ (void)deregisterURLPath:(NSString *)path{
    [VVManager sharedManager].urlRegList[path] = nil;
}

+ (BOOL)handleOpenURL:(NSURL *)url{
    NSAssert(url, @"url is nil!");
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    /** 1.检查scheme是否匹配 */
    NSArray *urlTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    NSMutableArray *schemes = [NSMutableArray array];
    for (NSDictionary *dic in urlTypes) {
        NSArray *tmpArray  = dic[@"CFBundleURLSchemes"];
        [schemes addObjectsFromArray:tmpArray];
    }
    BOOL match = NO;
    for (NSString *scheme in schemes) {
        if ([scheme.lowercaseString isEqualToString:components.scheme.lowercaseString]) {
            match = YES;
            break;
        }
    }
    
    if (!match) {
        return NO;
    }
    
    /** 2. 获取页面名 */
    NSString *name = (!components.path||components.path.length == 0)? components.host : components.path.lastPathComponent;
    VVHop *hop = [VVManager sharedManager].urlRegList[name];
    if (!hop) {
        return NO;
    }
    /** 3. 获取页面参数 */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    /** iOS8.0+
     for (NSURLQueryItem *item in components.queryItems) {
     [params addEntriesFromDictionary:@{item.name: item.value}];
     }
     */
    /** iOS7.0 */
    NSArray *itemStringArray = [components.query componentsSeparatedByString:@"&"];
    for (NSString *itemString in itemStringArray) {
        NSRange range = [itemString rangeOfString:@"="];
        if (range.location != NSNotFound) {
            NSString *key = [itemString substringToIndex:range.location];
            NSString *val = [itemString substringFromIndex:range.location + range.length];
            [params addEntriesFromDictionary:@{key:val}];
        }
    }

    hop.parameters = params;
    hop.controller = nil;  //将上一次调用该hop的controller置为nil,以便重新生成

    /** 4. 打开对应页面 */
    if (![VVManager sharedManager].appearFlag) {
        [VVManager sharedManager].planHop = hop;
    }
    else{
        [[self class] showPageWithHop:hop];
    }
    
    return YES;
}

#pragma mark - 工具类
+ (UIImage*)captureView:(UIView*)view backgroundColor:(UIColor *)backgroundColor{
    if(!view){
        return nil;
    }
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect rect = CGRectMake(0.0, 0.0, view.frame.size.width * scale, view.frame.size.height * scale);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 1.0);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, scale, scale);
    if(backgroundColor){
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, rect);
    }
    [view.layer renderInContext:context];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
