//
//  VVAppDelegate.m
//  VVManager
//
//  Created by pozi119 on 10/23/2017.
//  Copyright (c) 2017 pozi119. All rights reserved.
//

#import "VVAppDelegate.h"
#import "VVManager.h"

@implementation VVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self registerViewControllers];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)registerViewControllers{
    VVHop *hop1 = [VVHop hopWithMethod:VVHop_Pop aStoryboard:@"Main" aController:@"VVFavoriteMainController"];
    [VVManager registerURLPath:@"favorite" forHop:hop1];
    VVHop *hop2 = [VVHop hopWithMethod:VVHop_Pop aStoryboard:@"Main" aController:@"VVFavoriteDetailController"];
    [VVManager registerURLPath:@"favoriteDetail" forHop:hop2];
}
@end
