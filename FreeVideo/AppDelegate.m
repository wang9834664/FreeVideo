//
//  AppDelegate.m
//  FreeVideo
//
//  Created by wang on 14-3-28.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "HomeViewController.h"
#import "MovieViewController.h"
#import "TvViewController.h"
#import "VarietyViewController.h"
#import "CartoonViewController.h"
#import "SportViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) TWTSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) MenuViewController *menuViewController;

- (void)initTabBarCtrl;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.menuViewController = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
    
    [self initTabBarCtrl];
    
    
    self.sideMenuViewController = [[TWTSideMenuViewController alloc] initWithMenuViewController:self.menuViewController mainViewController:self.tabBarCtrl];
    
    self.sideMenuViewController.shadowColor = [UIColor blackColor];
    self.sideMenuViewController.edgeOffset = (UIOffset) { .horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 18.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 0.5634f : 0.85f;
    self.sideMenuViewController.delegate = self;
    self.window.rootViewController = self.sideMenuViewController;
    
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
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

- (void)initTabBarCtrl{
    self.tabBarCtrl = [[UITabBarController alloc] init];
    [self.tabBarCtrl.tabBar setHidden:YES];
    
    HomeViewController *homeViewCtrl = [[HomeViewController alloc] init];
    [self.tabBarCtrl addChildViewController:[[UINavigationController alloc] initWithRootViewController:homeViewCtrl]];
    
    MovieViewController *movieViewCtrl = [[MovieViewController alloc] init];
    [self.tabBarCtrl addChildViewController:[[UINavigationController alloc] initWithRootViewController:movieViewCtrl]];
    
    TvViewController *tvViewCtrl = [[TvViewController alloc] init];
    [self.tabBarCtrl addChildViewController:[[UINavigationController alloc] initWithRootViewController:tvViewCtrl]];
    
    VarietyViewController *varietyCtrl = [[VarietyViewController alloc] init];
    [self.tabBarCtrl addChildViewController:[[UINavigationController alloc] initWithRootViewController:varietyCtrl]];
    
    CartoonViewController *cartoonCtrl = [[CartoonViewController alloc] init];
    [self.tabBarCtrl addChildViewController:[[UINavigationController alloc] initWithRootViewController:cartoonCtrl]];
    
    SportViewController *sportCtrl = [[SportViewController alloc] init];
    [self.tabBarCtrl addChildViewController:[[UINavigationController alloc] initWithRootViewController:sportCtrl]];
}

#pragma mark - TWTSideMenuViewControllerDelegate

- (UIStatusBarStyle)sideMenuViewController:(TWTSideMenuViewController *)sideMenuViewController statusBarStyleForViewController:(UIViewController *)viewController
{
    if (viewController == self.menuViewController) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)sideMenuViewControllerWillOpenMenu:(TWTSideMenuViewController *)sender {
    NSLog(@"willOpenMenu");
}

- (void)sideMenuViewControllerDidOpenMenu:(TWTSideMenuViewController *)sender {
    NSLog(@"didOpenMenu");
}

- (void)sideMenuViewControllerWillCloseMenu:(TWTSideMenuViewController *)sender {
    NSLog(@"willCloseMenu");
}

- (void)sideMenuViewControllerDidCloseMenu:(TWTSideMenuViewController *)sender {
	NSLog(@"didCloseMenu");
}

@end
