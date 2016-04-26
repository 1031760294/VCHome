//
//  LeftViewController.h
//  VCHome
//
//  Created by adminsjp on 16/4/18.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController
- (IBAction)imageAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *loginame;

- (IBAction)signOutActioni:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;

@end
