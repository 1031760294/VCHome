//
//  TiJiaoViewController.h
//  VCHome
//
//  Created by adminsjp on 16/5/10.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TiJiaoViewController : UIViewController
- (IBAction)fenduan:(UISegmentedControl *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *emailNumber;
@property (weak, nonatomic) IBOutlet UITextField *personalNumber;
- (IBAction)tijiaoAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UILabel *lable;
@end
