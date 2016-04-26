//
//  personalViewController.h
//  VCHome
//
//  Created by adminsjp on 16/4/26.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personalViewController : UIViewController
- (IBAction)backAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UIImageView *imagerview;
- (IBAction)pickimage:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTF;
@property (weak, nonatomic) IBOutlet UITextField *genderTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
- (IBAction)confirmAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
