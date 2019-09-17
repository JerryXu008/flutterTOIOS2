//
//  AppDelegate.m
//  testFlutterToOC
//
//  Created by BruceXu on 2019/9/15.
//  Copyright © 2019 BruceXu. All rights reserved.
//

#import "AppDelegate.h"
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h> // Only if you have Flutter Plugins

//flutter_boost 测试
#import "DemoRouter.h"
#import "UIViewControllerDemo.h"
#import  "UIViewControllerDemo.h"

@interface AppDelegate (){
    FlutterPluginAppLifeCycleDelegate *_lifeCycleDelegate;
}

@end

@implementation AppDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
         _lifeCycleDelegate = [[FlutterPluginAppLifeCycleDelegate alloc] init];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    /*原生交互测试*/
//    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
//    [self.flutterEngine runWithEntrypoint:nil];
//
//    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
//    return[_lifeCycleDelegate  application:application didFinishLaunchingWithOptions:launchOptions];
    
    /*
     flutter_boost 测试
     */
    DemoRouter *router = [DemoRouter sharedRouter];
    //    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:router
    //                                                        onStart:^(FlutterEngine *fvc) {
    //
    //                                                        }];
    
    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:router onStart:^(id<FlutterBinaryMessenger,FlutterTextureRegistry,FlutterPluginRegistry> engine) {
        
    }];
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    
    
    [self.window makeKeyAndVisible];
    
    
    UIViewControllerDemo *vc = [[UIViewControllerDemo alloc] initWithNibName:@"UIViewControllerDemo" bundle:[NSBundle mainBundle]];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"hybrid" image:nil tag:0];
    
    
    FLBFlutterViewContainer *fvc = FLBFlutterViewContainer.new;
    [fvc setName:@"tab" params:@{}];
    fvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"flutter_tab" image:nil tag:1];
    
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    UINavigationController *rvc = [[UINavigationController alloc] initWithRootViewController:tabVC];
    
    
    router.navigationController = rvc;
    
    tabVC.viewControllers = @[vc,fvc];
    
    self.window.rootViewController = rvc;
    
    
    
    
    
    
    
    UIButton *nativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nativeButton.frame = CGRectMake(self.window.frame.size.width * 0.5 - 50, 200, 100, 45);
    nativeButton.backgroundColor = [UIColor redColor];
    [nativeButton setTitle:@"push native" forState:UIControlStateNormal];
    [nativeButton addTarget:self action:@selector(pushNative) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:nativeButton];
    
    return YES;
    
}

- (void)pushNative
{
    UINavigationController *nvc = (id)self.window.rootViewController;
    UIViewControllerDemo *vc = [[UIViewControllerDemo alloc] initWithNibName:@"UIViewControllerDemo" bundle:[NSBundle mainBundle]];
    [nvc pushViewController:vc animated:YES];
}



 
- (void)application:(UIApplication*)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings*)notificationSettings {
    [_lifeCycleDelegate application:application
didRegisterUserNotificationSettings:notificationSettings];
}
- (void)application:(UIApplication*)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    [_lifeCycleDelegate application:application
didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication*)application
didReceiveRemoteNotification:(NSDictionary*)userInfo
fetchCompletionHandler:(void(^)(UIBackgroundFetchResult result))completionHandler {
    [_lifeCycleDelegate application:application
       didReceiveRemoteNotification:userInfo
             fetchCompletionHandler:completionHandler];
}
- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options {
    return[_lifeCycleDelegate application:application openURL:url options:options];
}
-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url {
    return[_lifeCycleDelegate application:application handleOpenURL:url];
}
-(BOOL)application:(UIApplication*)application
           openURL:(NSURL*)url
 sourceApplication:(NSString*)sourceApplication
        annotation:(id)annotation {
    return[_lifeCycleDelegate application:application
                                  openURL:url
                        sourceApplication:sourceApplication
                               annotation:annotation];
}
- (void)application:(UIApplication*)application
performActionForShortcutItem:(UIApplicationShortcutItem*)shortcutItem
  completionHandler:(void(^)(BOOL succeeded))completionHandler NS_AVAILABLE_IOS(9_0) {
    [_lifeCycleDelegate application:application
       performActionForShortcutItem:shortcutItem
                  completionHandler:completionHandler];
}
- (void)application:(UIApplication*)application
handleEventsForBackgroundURLSession:(nonnull NSString*)identifier
  completionHandler:(nonnull void(^)(void))completionHandler {
    [_lifeCycleDelegate application:application
handleEventsForBackgroundURLSession:identifier
                  completionHandler:completionHandler];
}
- (void)application:(UIApplication*)application
performFetchWithCompletionHandler:(void(^)(UIBackgroundFetchResult result))completionHandler {
    [_lifeCycleDelegate application:application performFetchWithCompletionHandler:completionHandler];
}
- (void)addApplicationLifeCycleDelegate:(NSObject<FlutterPlugin>*)delegate {
    [_lifeCycleDelegate addDelegate:delegate];
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Flutter
// Returns the key window's rootViewController, if it's a FlutterViewController.
// Otherwise, returns nil.
- (FlutterViewController*)rootFlutterViewController {
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if([viewController isKindOfClass:[FlutterViewController class]]) {
        return(FlutterViewController*)viewController;
    }
    return nil;
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    [super touchesBegan:touches withEvent:event];
    // Pass status bar taps to key window Flutter rootViewController.
    if(self.rootFlutterViewController!= nil) {
        [self.rootFlutterViewController handleStatusBarTouches:event];
    }
}
@end
