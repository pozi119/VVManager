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
@property (nonatomic, assign) BOOL prtDebugInfo;               /**< 打印页面切换 */
@property (nonatomic, strong) NSMutableArray *viewControllers; /**< 记录当前的页面层次 */
@property (nonatomic, strong) NSMutableArray *naviControllers; /**< 记录当前的页面层次 */
@property (nonatomic, strong) NSMutableDictionary *urlRegList; /**< 页面url注册 */
@property (nonatomic, strong) NSArray *ignoredViewControllers; /**< 排除记录的页面 */
@property (nonatomic, copy) void (^appearExtraHandler)(UIViewController *);
@property (nonatomic, copy) void (^disappearExtraHandler)(UIViewController *);
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
    self.viewControllers = @[].mutableCopy;
    self.naviControllers = @[].mutableCopy;
    self.urlRegList      = @{}.mutableCopy;
    self.ignoredViewControllers  = @[@"UIInputWindowController",
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
    [[VVManager sharedManager] addViewController:viewController];
}

- (void)addViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UIViewController class]]) {
        NSString *vcStr = NSStringFromClass([viewController class]);
        __block BOOL ignore = NO;
        [self.ignoredViewControllers enumerateObjectsUsingBlock:^(NSString *ignoredVC, NSUInteger idx, BOOL *stop) {
            if ([ignoredVC isEqualToString:vcStr]) {
                ignore = YES;
                *stop  = YES;
            }
        }];
        if (ignore) {
            return;
        }
        [self.viewControllers addObject:viewController];
        [self printPathWithTag:@"Appear   "];
        if(self.appearExtraHandler){
            self.appearExtraHandler(viewController);
        }
    }
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self.naviControllers addObject:viewController];
    }
}

+ (void)removeViewController:(UIViewController *)viewController{
    [[VVManager sharedManager] removeViewController:viewController];
}

- (void)removeViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UIViewController class]] &&
        [self.viewControllers containsObject:viewController]) {
        [self printPathWithTag:@"Disappear"];
        [self.viewControllers removeObject:viewController];
        if (self.disappearExtraHandler) {
            self.disappearExtraHandler(viewController);
        }
    }
}

#pragma mark - 打印信息
+ (void)setPrtDebugInfo:(BOOL)prtDebugInfo{
    [VVManager sharedManager].prtDebugInfo = prtDebugInfo;
}

- (void)printPathWithTag:(NSString *)tag{
    if(self.prtDebugInfo){
        NSString *paddingItems = @"";
        for (NSUInteger i = 0; i <= self.viewControllers.count; i++){
            paddingItems = [paddingItems stringByAppendingFormat:@"--"];
        }
        NSLog(@"%@:%@> %@", tag, paddingItems, [self.viewControllers.lastObject description]);
    }
}

#pragma mark - 设置页面跳转时的额外操作
+ (void)setAppearExtraHandler:(void (^)(UIViewController *))appearExtraHandler{
    [VVManager sharedManager].appearExtraHandler = appearExtraHandler;
}

+ (void)setDisappearExtraHandler:(void (^)(UIViewController *))disappearExtraHandler{
    [VVManager sharedManager].disappearExtraHandler = disappearExtraHandler;
}

#pragma mark - 获取页面
+ (UIViewController *)currentViewController{
    return [VVManager sharedManager].viewControllers.lastObject;
}

+ (UINavigationController *)currentNaviController{
    if (self.currentViewController.navigationController) {
        return [VVManager currentViewController].navigationController;
    }
    else{
        return [VVManager sharedManager].naviControllers.lastObject;
    }
}

+ (UIViewController *)rootViewController{
    return [VVManager sharedManager].viewControllers.firstObject;
}

+ (UINavigationController *)rootNavigationController{
    return [VVManager sharedManager].naviControllers.firstObject;
}

#pragma mark - 页面跳转
+ (void)pushWithHop:(VVHop *)hop{
    if (!hop.controller) {
        return;
    }
    UINavigationController *nav = [VVManager currentNaviController];
    [nav pushViewController:hop.controller animated:hop.animated];
    if (hop.removeVCs.count > 0) {
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
    if (hop.alpha < 1.0 && hop.alpha > 0.0) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            destVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            hop.controller.view.alpha = hop.alpha;
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
        if ([scheme isEqualToString:components.scheme]) {
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
    [[self class] showPageWithHop:hop];
    
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
