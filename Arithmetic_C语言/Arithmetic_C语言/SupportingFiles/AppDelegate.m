//
//  AppDelegate.m
//  Arithmetic_C语言
//
//  Created by 谢佳培 on 2020/10/23.
//

#import "AppDelegate.h"
#import "CharacterViewController.h"
#import "ListViewController.h"
#import "ArrayViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ArrayViewController *rootVC = [[ArrayViewController alloc] init];
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = mainNC;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
