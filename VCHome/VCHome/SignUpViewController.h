//
//  SignUpViewController.h
//  VCHome
//
//  Created by ss on 16/4/16.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *registra;

- (IBAction)signUp:(UIButton *)sender forEvent:(UIEvent *)event;


@end
