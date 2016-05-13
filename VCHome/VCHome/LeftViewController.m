//
//  LeftViewController.m
//  VCHome
//
//  Created by adminsjp on 16/4/18.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "LeftViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    [self requsetData];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requsetData{
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"00000");
        
//        _nickname.hidden = YES;
        _nickname.text = currentUser[@"nickname"];
        PFFile *photofile = currentUser[@"headPortrait"];
        if(photofile){
            NSString *photoURLStr = photofile.url;
            NSURL *photoURL = [NSURL URLWithString:photoURLStr];
            
            NSLog(@"photoURL = %@",photoURL);
            //[_imv sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image5"]];
            [_imageBtn sd_setBackgroundImageWithURL:photoURL forState:UIControlStateNormal];
            
        }else{
            [_imageBtn setBackgroundImage:[UIImage imageNamed:@"Image-3"] forState:UIControlStateNormal];        }
        
        
    }else{
        [_imageBtn setBackgroundImage:[UIImage imageNamed:@"Image-3"] forState:UIControlStateNormal];
                _nickname.text = @"未登录";
    }
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)imageAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *currentUser  = [PFUser currentUser];
    NSLog(@"currentUser = %@",currentUser);
    if (currentUser) {
        UINavigationController *mineVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"person"];
        [self presentViewController:mineVC animated:YES completion:nil];
        
        
        
    }else{
        
        NSLog(@"当前用户没登录");
        UINavigationController *SignVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Sign"];
        [self presentViewController:SignVC animated:YES completion:nil];
        
        
    }

    

}

- (IBAction)signOutActioni:(UIButton *)sender forEvent:(UIEvent *)event {
    //退出登录
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        //判断退出是否成功
        if (!error) {
            //返回登录页面
             UINavigationController *SignVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Sign"];
             [self presentViewController:SignVC animated:YES completion:nil];
        }else{
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
    }];

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
