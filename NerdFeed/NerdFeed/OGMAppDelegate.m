//
//  AppDelegate.m
//  NerdFeed
//
//  Created by Omri Meshulam on 3/19/15.
//  Copyright (c) 2015 Omri Meshulam. All rights reserved.
//

#import "OGMAppDelegate.h"
#import "OGMCoursesViewController.h"
#import "OGMWebViewController.h"

@interface OGMAppDelegate ()

@end

@implementation OGMAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    OGMCoursesViewController *cvc = [[OGMCoursesViewController alloc]initWithStyle:UITableViewStylePlain];
    
    UINavigationController *masterNav = [[UINavigationController alloc]initWithRootViewController:cvc];
    
    OGMWebViewController *wvc = [[OGMWebViewController alloc]init];
    cvc.webViewController = wvc;
    
    // Checking to make sure we are running on an ipad
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        
        // webViewController must be in navigation controller; you will see why later
        UINavigationController *detailNav = [[UINavigationController alloc]initWithRootViewController:wvc];
       
        UISplitViewController *svc = [[UISplitViewController alloc]init];
        
        
        // Setting the delegate of the split view controller to the detail VC
        // You will see why later - ignore warning
        svc.delegate = wvc;
        
        svc.viewControllers = @[masterNav, detailNav];
        
        // Setting the root view controllers of the window to the split view controller
        self.window.rootViewController = svc;
    }else{
        // On noniPad devices
        self.window.rootViewController = masterNav;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
