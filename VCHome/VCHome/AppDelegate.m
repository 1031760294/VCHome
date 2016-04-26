//
//  AppDelegate.m
//  VCHome
//
//  Created by adminsjp on 16/4/16.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "AppDelegate.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "LeftViewController.h"
#import "TabViewController.h"
@interface AppDelegate ()
@property(strong, nonatomic) ECSlidingViewController *slidingVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse setApplicationId:@"LctPkSrN0dJQ2vChx4agzXPPSnBjzh4vLrPKtDeD" clientKey:@"fkrFFb8rZ4oPRc39OFVcsyXzXZgNGdFDWGWWx9xY"];
    //激活Parse数据库的大数据分析整合功能
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    //请求获取位置服务
    CLLocationManager *location=[[CLLocationManager alloc]init];
    
    [location requestAlwaysAuthorization];
    //根据故事版的名称和故事版中页面的名称获得这个页面
    TabViewController *tabVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Tab"];
    
    //初始化移门的门框,并设置中间那扇门
    _slidingVC = [ECSlidingViewController slidingWithTopViewController:tabVC];
    //设置开门关门的耗时    _slidingVC.defaultTransitionDuration = 0.25f;
    //设置控制门开关的手势(这里同时对触摸和拖拽响应)
    _slidingVC.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGesturePanning|ECSlidingViewControllerAnchoredGestureTapping;
    
    //设置上述手势的识别范围
    [tabVC.view addGestureRecognizer:_slidingVC.panGesture];
    
    //根据故事版id获得左滑页面的实例
    LeftViewController *leftVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Left"];
    //设置移门靠左的那扇门
    _slidingVC.underLeftViewController = leftVC;
    //设置移门的开闭程度(设置左侧页面显示时，可以显示屏幕宽度3/4宽度)
    _slidingVC.anchorRightPeekAmount = UI_SCREEN_W / 3;
    
    //创建一个菜单按钮被按时要执行侧滑方法的通知
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(menuSwitchAction) name:@"MenuSwitch" object:nil];
    
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(EnableGestureAction) name:@"EnableGesture" object:nil];
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(DisableGestureAtion) name:@"DisableGesture" object:nil];
    
    //modal方式跳转到上述页面
    [self.window setRootViewController:_slidingVC];
    
    return YES;


    return YES;
}
-(void)menuSwitchAction {
    NSLog(@"菜单被按了");
    if (_slidingVC.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        //上述表示中间门在右侧，说明门是打开的，因此我们要将它关闭，移回中间
        [_slidingVC resetTopViewAnimated:YES];
        
    }else {
        //反之将中间的门移到右边
        [_slidingVC anchorTopViewToRightAnimated:YES];
    }
    
}

//激活移门手势
-(void)EnableGestureAction {
    _slidingVC.panGesture.enabled = YES;
    
}

//关闭移门手势
-(void)DisableGestureAtion {
    _slidingVC.panGesture.enabled = NO;
    
    
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "vch.VCHome" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"VCHome" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"VCHome.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
