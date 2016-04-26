//
//  SignInViewController.m
//  VCHome
//
//  Created by ss on 16/4/16.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "ForgetPwdViewController.h"
#import "TabViewController.h"
#import "KSGuideManager.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "LeftViewController.h"

@interface SignInViewController ()
@property(strong, nonatomic) ECSlidingViewController *slidingVC;


@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    //第一次进入的引导动画
    
        NSMutableArray *paths = [NSMutableArray new];
        [paths addObject:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"]];
        [paths addObject:[[NSBundle mainBundle] pathForResource:@"12" ofType:@"jpg"]];
        [paths addObject:[[NSBundle mainBundle] pathForResource:@"13" ofType:@"jpg"]];
        [paths addObject:[[NSBundle mainBundle] pathForResource:@"14" ofType:@"jpg"]];
        [[KSGuideManager shared] showGuideViewWithImages:paths];
        

}
//每一次这个页面出现的时候都会调用和这个方法，并且时机点页面将要出现之前
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
       if (![[Utilities getUserDefaults:@"username"] isKindOfClass:[NSNull class]]) {
        //如果有记忆就把记忆显示在用户名文本输入框
        _username.text = [Utilities getUserDefaults:@"username"];
           [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    }
}
//每一次这个页面出现的时候都会调用这个方法，并且时机点是页面已然出现以后
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //判断是否是从注册页面注册成功后回到的这个登录页面
    if ([[[StorageMgr singletonStorageMgr]objectForKey:@"SignUpsuccessfully"] boolValue] ) {
        // 在自动登录前将flag恢复默认为NO
        [[StorageMgr singletonStorageMgr]removeObjectForKey:@"SignUpsuccessfully"];
        [[StorageMgr singletonStorageMgr]addKey:@"SignUpsuccessfully" andValue:@NO];
        //从单例化全局变量中提取用户名和密码
        NSString *username = [[StorageMgr singletonStorageMgr]objectForKey:@"username"];
        NSString *password = [[StorageMgr singletonStorageMgr]objectForKey:@"uassword"];
        //执行自动登录
        [self signInWithUsername:username andPassword:password];
        //清除用完的用户名和密码
        [[StorageMgr singletonStorageMgr]removeObjectForKey:@"username"];
        [[StorageMgr singletonStorageMgr]removeObjectForKey:@"uassword"];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void)signInWithUsername:(NSString *)username andPassword:(NSString *)password{
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        //登录完成后的回调
        [avi stopAnimating];
        //判断登录是否成功
        if (user) {
            NSLog(@"登陆成功");
            //记忆用户名
            [Utilities setUserDefaults:@"username" content:username];
            //将密码文本输入框中的内容清除
            _password.text = @"";
            //跳转到首页
            [self popUpHome];
        }
        else {
            switch (error.code) {
                case 101:
                    [Utilities popUpAlertViewWithMsg:@"用户名或密码错误" andTitle:nil onView:self];
                    break;
                case 100:
                    [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil onView:self];
                    break;
                default:[Utilities popUpAlertViewWithMsg:@"服务器正在维护，请稍后再试" andTitle:nil onView:self];
                    break;
            }
        }
    }];
}

-(void)popUpHome {
    
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
    [self presentViewController:_slidingVC animated:YES completion:nil];
    
}
//激活移门手势
-(void)EnableGestureAction {
    _slidingVC.panGesture.enabled = YES;
    
}

//关闭移门手势
-(void)DisableGestureAtion {
    _slidingVC.panGesture.enabled = NO;
    
    
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



- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _username.text;
    NSString *password =  _password.text;
    if (username.length == 0 || password.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil onView:self];
        return;
    }
    //执行登录
    [self signInWithUsername:username andPassword:password];
}

//按return收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}


@end
