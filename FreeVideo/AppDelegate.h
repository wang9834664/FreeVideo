//
//  AppDelegate.h
//  FreeVideo
//
//  Created by wang on 14-3-28.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTSideMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, TWTSideMenuViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarCtrl;
@end
