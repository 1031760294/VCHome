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
@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//每一次这个页面出现的时候都会调用和这个方法，并且时机点页面将要出现之前
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![[Utilities getUserDefaults:@"username"] isKindOfClass:[NSNull class]]) {
        //如果有记忆就把记忆显示在用户名文本输入框
        _username.text = [Utilities getUserDefaults:@"username"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
            //[self popUpHome];
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

- (IBAction)ForgetPwd:(UIButton *)sender forEvent:(UIEvent *)event {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     ForgetPwdViewController*ForgetView = [story instantiateViewControllerWithIdentifier:@"Forgetpwd"];
    [self.navigationController pushViewController:ForgetView animated:YES];

}

- (IBAction)Regirsta:(UIButton *)sender forEvent:(UIEvent *)event {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignUpViewController*SignUpView = [story instantiateViewControllerWithIdentifier:@"SignUp"];
    [self.navigationController pushViewController:SignUpView animated:YES];
    

}

@end