//
//  ViewController.m
//  testFlutterToOC
//
//  Created by BruceXu on 2019/9/15.
//  Copyright © 2019 BruceXu. All rights reserved.
//

#import <Flutter/Flutter.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "TargetViewController.h"
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(handleButtonAction)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (void)handleButtonAction {
//    FlutterEngine *flutterEngine = [(AppDelegate *)[[UIApplication sharedApplication] delegate] flutterEngine];
//
//    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
//
//
//    [self presentViewController:flutterViewController animated:false completion:nil];

    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
   
    FlutterBasicMessageChannel* messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"channel"
                                                                                    binaryMessenger:flutterViewController
                                                                                              codec:[FlutterStandardMessageCodec sharedInstance]];//消息发送代码，本文不做解释
    __weak __typeof(self) weakSelf = self;
    [messageChannel setMessageHandler:^(id message, FlutterReply reply) {
        // Any message on this channel pops the Flutter view.
        [[weakSelf navigationController] popViewControllerAnimated:YES];
        reply(@"");
    }];
    NSAssert([self navigationController], @"Must have a NaviationController");
    [[self navigationController]  pushViewController:flutterViewController animated:YES];
}

- (void)pushFlutterViewController {
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
   
    
    
    
    // 设置路由名字 跳转到不同的flutter界面
    /*
     import 'dart:ui';
     
     void main() => runApp(_widgetForRoute(window.defaultRouteName));
     
     Widget _widgetForRoute(String route) {
     switch (route) {
     case 'myApp':
     return new MyApp();
     case 'home':
     return new HomePage();
     default:
     return Center(
     child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
     );
     }
     }
     */
    
    //    [flutterViewController setInitialRoute:@"home"];
    [flutterViewController setInitialRoute:@"myApp"];
   // __weak __typeof(self) weakSelf = self;
    
    // 要与main.dart中一致
    NSString *channelName = @"com.pages.your/native_get";
    
    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:flutterViewController];
    
    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
        NSLog(@"method=%@ \narguments = %@", call.method, call.arguments);
        
        // method和WKWebView里面JS交互很像
        if ([call.method isEqualToString:@"toNativePush"]) {
            TargetViewController *vc = [[TargetViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([call.method isEqualToString:@"toNativePop"]) {
            NSDictionary *dic = call.arguments;
            NSLog(@"arguments = %@", dic);
            NSString *code = dic[@"code"];
            NSArray *data = dic[@"data"];
            NSLog(@"code = %@", code);
            NSLog(@"data = %@",data);
            NSLog(@"data 第一个元素%@",data[0]);
            NSLog(@"data 第一个元素类型%@",[data[0] class]);
            
        }
        if ([call.method isEqualToString:@"toNativeSomething"]) {
            if (result) {
                // iOSFlutter2 对应的方法flutter中主动出发 并且将下面的值（Native的值）传给flutter
                result(@"10000");
            }
        }
    }];
    
    [self.navigationController pushViewController:flutterViewController animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self pushFlutterViewController];
}


@end
