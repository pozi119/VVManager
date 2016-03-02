//
//  VOVCManager.m
//  joylife
//
//  Created by Valo on 15/4/25.
//  Copyright (c) 2015年 ValoLee. All rights reserved.
//

#import "VOVCManager.h"

#pragma mark - VOVCManager,页面管理器

@interface VOVCManager ()
@property (nonatomic, strong) NSMutableArray *viewControllers; /**< 记录当前的页面层次 */
@property (nonatomic, strong) NSMutableArray *naviControllers; /**< 记录当前的页面层次 */
@property (nonatomic, strong) NSMutableArray *registerList;    /**< 页面url注册 */
@property (nonatomic, strong) NSArray *ignoredViewControllers; /**< 排除记录的页面 */
@property (nonatomic, copy) void (^appearExtraHandler)(UIViewController *);
@property (nonatomic, copy) void (^disappearExtraHandler)(UIViewController *);
@end

@implementation VOVCManager

#pragma mark - 创建单例对象
+ (instancetype)sharedManager{
    static VOVCManager *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[[self class] alloc] init];
    });
    return _sharedManager;
}

#pragma mark - utils
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

#pragma mark - 当前页面
- (UIViewController *)currentViewController{
    return [VVManager currentViewController];
}

- (UINavigationController *)currentNaviController{
    return [VVManager currentNaviController];
}

- (UIViewController *)rootViewController{
    return [VVManager rootViewController];
}

- (UINavigationController *)rootNavigationController{
    return [VVManager rootNavigationController];
}


#pragma mark - 页面创建
#pragma mark 从Xib或者代码创建页面
- (UIViewController *)viewController:(NSString *)aController storyboard:(NSString *)aStoryboard{
    return [self viewController:aController storyboard:aStoryboard params:nil];
}

- (UIViewController *)viewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams{
    return [VVHop viewController:aController storyboard:aStoryboard params:aParams];
}


#pragma mark - 页面跳转,Push
- (void)pushController:(NSString *)aController storyboard:(NSString *)aStoryboard{
    [self pushController:aController storyboard:aStoryboard params:nil];
}

- (void)pushController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams{
    [self pushController:aController storyboard:aStoryboard params:aParams animated:YES];
}

- (void)pushController:(NSString *)aController storyboard:(NSString *)aStoryboard animated:(BOOL)animated{
    [self pushController:aController storyboard:aStoryboard params:nil animated:animated];
}

- (void)pushController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams animated:(BOOL)animated{
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:aStoryboard aController:aController parameters:aParams];
    [VVManager showPageWithHop:hop];
}

- (void)pushController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams animated:(BOOL)animated removeControllers:(NSArray *)removeControllers{
    VVHop *hop = [VVHop hopWithMethod:VVHop_Push aStoryboard:aStoryboard aController:aController parameters:aParams];
    hop.animated = animated;
    hop.removeVCs = removeControllers;
    [VVManager showPageWithHop:hop];
}



#pragma mark - 页面出栈
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    VVHop *hop = [[VVHop alloc] init];
    hop.animated = animated;
    hop.method = VVHop_Pop;
    [VVManager showPageWithHop:hop];
    return nil;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    VVHop *hop = [[VVHop alloc] init];
    NSArray *vcs = [VVManager currentNaviController].viewControllers;
    if (vcs.count > 0) {
        hop.controller = vcs.firstObject;
    }
    hop.animated = animated;
    hop.method = VVHop_Pop;
    [VVManager showPageWithHop:hop];
    return nil;
}

- (NSArray *)popToViewController:(NSString *)aController storyboard:(NSString *)aStoryboard{
    return [self popToViewController:aController storyboard:aStoryboard params:nil];
}

- (NSArray *)popToViewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams{
    return [self popToViewController:aController storyboard:aStoryboard params:aParams animated:YES];
}

- (NSArray *)popToViewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams animated:(BOOL)animated{
    VVHop *hop = [VVHop hopWithMethod:VVHop_Pop aStoryboard:aStoryboard aController:aController parameters:aParams];
    hop.animated = animated;
    [VVManager showPageWithHop:hop];
    return [VVManager currentNaviController].viewControllers;
}

- (NSArray *)popExcludeViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
    VVHop *hop = [[VVHop alloc] init];
    hop.removeVCs = viewControllers;
    hop.animated = animated;
    hop.method = VVHop_Pop;
    [VVManager showPageWithHop:hop];
    return [VVManager currentNaviController].viewControllers;
}

#pragma mark - 页面显示,present
- (UIViewController *)presentViewController:(NSString *)aController storyboard:(NSString *)aStoryboard{
    return [self presentViewController:aController storyboard:aStoryboard params:nil];
}

- (UIViewController *)presentViewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams{
    return [self presentViewController:aController storyboard:aStoryboard params:aParams destInNavi:YES];
}

- (UIViewController *)presentViewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams destInNavi:(BOOL)destInNavi{
    return [self presentViewController:aController storyboard:aStoryboard params:aParams sourceWithNavi:YES destInNavi:destInNavi completion:nil];
}

- (UIViewController *)presentViewController:(NSString *)aController
                   storyboard:(NSString *)aStoryboard
                       params:(NSDictionary *)aParams
               sourceWithNavi:(BOOL)sourceWithNavi
                   destInNavi:(BOOL)destInNavi
                   completion:(void (^)(void))completion{
    return [self presentViewController:aController storyboard:aStoryboard params:aParams sourceWithNavi:sourceWithNavi destInNavi:destInNavi alpha:1 animated:YES completion:completion];
}

- (UIViewController *)presentViewController:(NSString *)aController
                                 storyboard:(NSString *)aStoryboard
                                     params:(NSDictionary *)aParams
                             sourceWithNavi:(BOOL)sourceWithNavi
                                 destInNavi:(BOOL)destInNavi
                                      alpha:(CGFloat)alpha
                                   animated:(CGFloat)animated
                                 completion:(void (^)(void))completion{
    UIViewController *destVC = [self viewController:aController storyboard:aStoryboard params:aParams];
    return [self presentViewController:destVC sourceWithNavi:sourceWithNavi destInNavi:destInNavi alpha:alpha animated:animated completion:completion];
}

- (UIViewController *)presentViewController:(UIViewController *)viewController
                             sourceWithNavi:(BOOL)sourceWithNavi
                                 destInNavi:(BOOL)destInNavi
                                      alpha:(CGFloat)alpha
                                   animated:(CGFloat)animated
                                 completion:(void (^)(void))completion{
    VVHop *hop = [[VVHop alloc] init];
    hop.controller = viewController;
    hop.soruceInNav = sourceWithNavi;
    hop.destInNav = destInNavi;
    hop.alpha = alpha;
    hop.animated = animated;
    hop.method = VVHop_Present;
    [VVManager showPageWithHop:hop];
    return [VVManager currentViewController];
}

- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion{
    [self dismissViewControllerWithNavi:NO animated:animated completion:completion];
}

- (void)dismissViewControllerWithNavi:(BOOL)withNavi animated:(BOOL)animated  completion:(void (^)(void))completion{
    VVHop *hop = [[VVHop alloc] init];
    hop.soruceInNav = withNavi;
    hop.animated = animated;
    hop.completion = completion;
    hop.method = VVHop_Dismiss;
    [VVManager showPageWithHop:hop];
}

- (void)dismissToNavigationControllerCompletion:(void (^)(void))completion{
    if(!self.currentViewController.navigationController && self.naviControllers.count > 1) {
        [self dismissViewControllerAnimated:NO completion:^{
            [self dismissToNavigationControllerCompletion:completion];
        }];
    }
    else{
        if (completion) {
            completion();
        }
    }
}

#pragma mark - 页面URL管理

- (void)registerWithSpec:(NSDictionary *)spec{
    
}

- (void)registerName:(NSString *)name forViewController:(NSString *)aController inStoryboard:(NSString *)aStoryboard isPresent:(BOOL)isPresent{
    
}

- (void)cancelRegisterName:(NSString *)name{
    
}

- (BOOL)handleOpenURL:(NSURL *)url{
    return [VVManager handleOpenURL:url];
}

@end
