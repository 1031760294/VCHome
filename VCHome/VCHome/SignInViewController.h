//
//  SignInViewController.h
//  VCHome
//
//  Created by ss on 16/4/16.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)backAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
