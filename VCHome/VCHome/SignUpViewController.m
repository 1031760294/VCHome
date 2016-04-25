//
//  SignUpViewController.m
//  VCHome
//
//  Created by ss on 16/4/16.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
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

- (IBAction)signUp:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _username.text;
    NSString *email = _email.text;
    NSString *password = _password.text;
    NSString *registra = _registra.text;
    if (username.length ==0 || email.length ==0 ||password.length ==0 || registra.length ==0) {
        //提示框
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil onView:self];
        return;
        
    }
    if (![password isEqualToString:registra]) {
        [Utilities popUpAlertViewWithMsg:@"确认密码必须与密码保持一致" andTitle:nil onView:self];
        return;
    }
    //在parse表中自带的user表中新建一行
    PFUser *user = [PFUser user];
    //设置用户名，邮箱和密码
    user.username = username;
    user.email = email;
    user.password = password;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //开始注册
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        //注册完成后的回调
        //菊花停止转
        [avi stopAnimating];
        if (succeeded) {
            NSLog(@"注册成功");
            //先将SignUpsuccessfully这个单例化全局变量中的Flag删除以保证该flag的唯一性
            [[StorageMgr singletonStorageMgr]removeObjectForKey:@"SignUpsuccessfully"];
            //然后将这个flag设置为yes来表示注册成功了
            [[StorageMgr singletonStorageMgr]addKey:@"SignUpsuccessfully" andValue:@YES];
            //在单例化全局变量中保存用户名和密码以供登录页面自动登录使用
            [[StorageMgr singletonStorageMgr]addKey:@"Username" andValue:username];
            [[StorageMgr singletonStorageMgr]addKey:@"Password" andValue:password];
            //将文本输入框的内容清除
            _password.text =@"";
            _registra.text = @"";
            _username.text = @"";
            _email.text = @"";
            //回到登录页面
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            switch (error.code) {
                case 202:
                    [Utilities popUpAlertViewWithMsg:@"该用户名已被使用" andTitle:nil onView:self];
                    break;
                case 203:
                    [Utilities popUpAlertViewWithMsg:@"该电子邮箱已被使用" andTitle:nil onView:self];
                    break;
                case 100:
                    [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil onView:self];
                    break;
                case 125:
                    [Utilities popUpAlertViewWithMsg:@"该电子邮箱不存在" andTitle:nil onView:self];
                    break;
                    
                    
                default:[Utilities popUpAlertViewWithMsg:@"服务器正在维护，请稍后再试" andTitle:nil onView:self];
                    break;
            }
        }
    }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}

@end
