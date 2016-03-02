//
//  VVHop.m
//  VOVCManagerDemo
//
//  Created by Valo on 16/2/24.
//  Copyright © 2016年 valo. All rights reserved.
//

#import "VVHop.h"

@implementation VVHop

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        _alpha = 1.0;
        _soruceInNav = YES;
        _animated = YES;
    }
    return self;
}

+ (instancetype)hopWithDictionary:(NSDictionary *)dic{
    VVHop *hop = [[VVHop alloc] init];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL * stop) {
        [hop setValue:value forKey:key];
    }];
    return hop;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    // Do nothing;
}

+ (instancetype)hopWithMethod:(VVHopMethod)method
                   controller:(UIViewController *)controller{
    return [[self class] hopWithMethod:method controller:controller parameters:nil];
}

+ (instancetype)hopWithMethod:(VVHopMethod)method
                   controller:(UIViewController *)controller
                   parameters:(NSDictionary *)parameters{
    VVHop *hop = [[VVHop alloc] init];
    hop.method = method;
    hop.controller = controller;
    hop.parameters = parameters;
    return hop;
}

+ (instancetype)hopWithMethod:(VVHopMethod)method
                  aStoryboard:(NSString *)aStoryboard
                  aController:(NSString *)aController{
    return [[self class] hopWithMethod:method aStoryboard:aStoryboard aController:aController parameters:nil];
}

+ (instancetype)hopWithMethod:(VVHopMethod)method
                  aStoryboard:(NSString *)aStoryboard
                  aController:(NSString *)aController
                   parameters:(NSDictionary *)parameters{
    VVHop *hop = [[VVHop alloc] init];
    hop.method = method;
    hop.aStoryboard = aStoryboard;
    hop.aController = aController;
    hop.parameters = parameters;
    return hop;
}

#pragma mark - 私有方法
- (UIViewController *)controller{
    if (!_controller) {
        _controller = [[self class] viewController:_aController storyboard:_aStoryboard params:_parameters];
    }
    return _controller;
}

+ (UIViewController *)viewController:(NSString *)aController storyboard:(NSString *)aStoryboard params:(NSDictionary *)aParams{
    // 1. 参数检查
    if(!aController || aController.length == 0){
        return nil;
    }
    
    Class clazz = NSClassFromString(aController);
    if(!clazz){
        return nil;
    }
    
    // 2. 创建VC
    UIViewController *viewController = nil;
    if(aStoryboard && aStoryboard.length > 0){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:aStoryboard bundle:nil];
        if (storyboard) {
            viewController = [storyboard instantiateViewControllerWithIdentifier:aController];
        }
    }
    else{
        viewController = [[clazz alloc] initWithNibName:nil bundle:nil];
        if(!viewController){
            viewController = [[clazz alloc] init];
        }
    }
    
    // 3. 设置ViewController参数
    [[self class] setParams:aParams forObject:viewController];
    
    return viewController;
}

+ (void)setParams:(NSDictionary *)params forObject:(NSObject *)obj{
    if (!params || ![params isKindOfClass:[NSDictionary class]]) {
        return;
    }
    for (NSString *key in params.allKeys) {
        id value = params[key];
        if (value && ![value isKindOfClass:[NSNull class]]) {
            NSString *capital = [[key substringToIndex:1] uppercaseString];
            NSString *capitalizedKey  = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:capital];
            SEL sel = NSSelectorFromString([NSString stringWithFormat:@"set%@:",capitalizedKey]);
            if ([obj respondsToSelector:sel]) {
                [obj setValue:value forKey:key];
            }
        }
    }
}


@end
