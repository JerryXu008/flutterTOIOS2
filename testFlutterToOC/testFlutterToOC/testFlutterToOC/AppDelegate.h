//
//  AppDelegate.h
//  testFlutterToOC
//
//  Created by BruceXu on 2019/9/15.
//  Copyright © 2019 BruceXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
//@interface AppDelegate : UIResponder <UIApplicationDelegate>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

#import <flutter_boost/FlutterBoost.h>

@interface AppDelegate : FLBFlutterAppDelegate //FlutterAppDelegate
@property (nonatomic,strong) FlutterEngine *flutterEngine;
@end
//@property (strong, nonatomic) UIWindow *window;
//
//
//@end

